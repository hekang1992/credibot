//
//  DeviceIdentifierManager.swift
//  credibot
//
//  Created by 何康 on 2025/6/12.
//

import UIKit
import Foundation
import KeychainAccess
import AdSupport
import AppTrackingTransparency

class DeviceIdentifierManager {
    
    private static let service = Bundle.main.bundleIdentifier ?? "com.credibot.app"
    
    private static let idfvKey = "com.credibot.device.idfv.app"
    
    static func getIDFV() -> String? {
        let keychain = Keychain(service: service)
        if let savedIDFV = keychain[idfvKey] {
            return savedIDFV
        } else if let idfv = UIDevice.current.identifierForVendor?.uuidString {
            keychain[idfvKey] = idfv
            return idfv
        } else {
            return nil
        }
    }
    
    static func getIDFA(completion: @escaping (String?) -> Void) {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .authorized:
                    let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                    completion(idfa == "00000000-0000-0000-0000-000000000000" ? nil : idfa)
                default:
                    completion(nil)
                }
            }
        } else {
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
                completion(idfa)
            } else {
                completion(nil)
            }
        }
    }
    
}
