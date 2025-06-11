//
//  location.swift
//  credibot
//
//  Created by 何康 on 2025/6/11.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

struct LocationModel {
    var latitude: Double?
    var longitude: Double?
    var address: String?
}

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let subject = PublishSubject<LocationModel?>()
    private let disposeBag = DisposeBag()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocationOnce() -> Observable<LocationModel?> {
        checkAuthorizationStatus()
        
        return subject
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .take(1)
            .do(onDispose: { [weak self] in
                self?.locationManager.stopUpdatingLocation()
            })
    }

    private func checkAuthorizationStatus() {
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .restricted, .denied:
            subject.onNext(nil)
            subject.onCompleted()
        @unknown default:
            subject.onNext(nil)
            subject.onCompleted()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkAuthorizationStatus()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            subject.onNext(nil)
            subject.onCompleted()
            return
        }

        CLGeocoder().reverseGeocodeLocation(location) { placemarks, _ in
            let address = placemarks?.first?.name
            let model = LocationModel(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude,
                address: address
            )
            self.subject.onNext(model)
            self.subject.onCompleted()
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("🚀==========: \(error.localizedDescription)")
        subject.onNext(nil)
        subject.onCompleted()
    }
}
