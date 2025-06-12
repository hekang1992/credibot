//
//  location.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/6/11.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

let s1 = "i"
struct LocationModel {
    var countryCode: String?
    var proviceCode: String?
    var country: String?
    var street: String?
    var latitude: Double?
    var longitude: Double?
    var address: String?
    var city: String?
}

class LocationFetcher: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    private let subject = PublishSubject<LocationModel?>()
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocationOnce() -> Observable<LocationModel?> {
        checkAuthorizationStatus()
        let obs = subject
            .debounce(.seconds(1), scheduler: MainScheduler.instance)
            .take(1)
            .do(onDispose: {
                self.locationManager.stopUpdatingLocation()
            })
        return obs
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
            guard let placemark = placemarks?.first else {
                self.subject.onNext(nil)
                self.subject.onCompleted()
                return
            }
            let model = LocationModel(
                countryCode: placemark.isoCountryCode,
                proviceCode: placemark.administrativeArea,
                country: placemark.country,
                street: placemark.thoroughfare,
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude,
                address: placemark.thoroughfare,
                city: placemark.locality ?? placemark.subAdministrativeArea
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
