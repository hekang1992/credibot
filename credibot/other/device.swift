//
//  device.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/6/11.
//

import UIKit

class CFPrivateEntry {
    
    static let shared = CFPrivateEntry()
    
    let ordered: String
    let amusement: String
    let talkative: String
    let jacksshoulder: String?
    let ashore: Int
    let ruins: Int
    let dict: [String: [String: Any]]
    
    init() {
        ordered = s1 + s2 + s3
        amusement = UIDevice.current.systemVersion
        talkative = DebugInfo.getLastTime()
        jacksshoulder = DebugInfo.getAppBundleIdentifier()
        ashore = DebugInfo.getBatteryPercentage() ?? -1
        ruins = DebugInfo.isCharging()
        dict = ["leaving": ["ashore": ashore, "ruins": ruins]]
    }
    
   static func returnDict() -> [String: Any] {
        return [
            "ordered": shared.ordered,
            "amusement": shared.amusement,
            "talkative": shared.talkative,
            "jacksshoulder": shared.jacksshoulder ?? "",
            "ashore": shared.ashore,
            "ruins": shared.ruins,
            "nested_dict": shared.dict
        ]
    }
    
}

class SCSignalManager {
    
    static let shared = SCSignalManager()
    
    init() {
        
    }
    
}

class CNServiceRouter {
    
}
