//
//  point.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/6/12.
//

import RxSwift

class ClickTracking {

    static func trackingAppInfo(model: LocationModel, para: [String: String]) async {
        let man = NetworkManager()
        let dict1 = ["oftimber": String(model.latitude ?? 0),
                     "holding": String(model.longitude ?? 0),
                     "chant": "",
                     "choo": DeviceIdentifier.getIDFV(),
                     "hoo": DeviceIdentifier.getIDFA()]
        let mergedDict = dict1.merging(para) { (current, _) in current }
        
        do {
            let _ = try await man.request(.postData(endpoint: "/cbd/these", parameters: mergedDict), responseType: BaseModel.self)
        } catch {
            print("Error sending tracking data: \(error)")
        }
    }
}

