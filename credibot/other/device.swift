//
//  device.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/6/11.
//

import UIKit
import DeviceKit
import SystemServices

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
    
    let noback: String
    let temples: String
    let thousands: String
    let staring: Int
    let tosee: Int
    let either: Int
    let whyisnt: Int
    let dontunderstand: Int
    let droves: String
    let milling: String
    let crowds: String
    
    let andhere: String
    let temple: String
    
    init() {
        noback = DeviceIdentifier.getIDFV()
        temples = DeviceIdentifier.getIDFA()
        thousands = NetInfoConfig.getWiFiBSSID()
        staring = SCSignalManager.getCurrentTime()
        tosee = SCSignalManager.isUsingProxy()
        either = SCSignalManager.isUsingVPN()
        whyisnt = BorkenConfig.isJailbroken()
        dontunderstand = BorkenConfig.isSimulator()
        droves = Locale.preferredLanguages.first ?? "en"
        milling = ""
        crowds = "NetInfoManager.shared.currentStatus"
        andhere = NSTimeZone.system.abbreviation() ?? ""
        temple = BorkenConfig.systemUptime()
    }
    
    static func returnDict() -> [String: Any] {
        return ["ofyears": ["noback": shared.noback,
                            "temples": shared.temples,
                            "thousands": shared.thousands,
                            "staring": shared.staring,
                            "tosee": shared.tosee,
                            "either": shared.either,
                            "whyisnt": shared.whyisnt,
                            "dontunderstand": shared.dontunderstand,
                            "droves": shared.droves,
                            "milling": shared.milling,
                            "crowds": shared.crowds,
                            "andhere": shared.andhere,
                            "temple": shared.temple]
        ]
    }
    
    
    static func getCurrentTime() -> Int {
        let timestampInSeconds = Int(Date().timeIntervalSince1970 * 1000)
        return timestampInSeconds
    }
    
    static func isUsingProxy() -> Int {
        guard let proxySettings = CFNetworkCopySystemProxySettings()?.takeUnretainedValue() as? [String: Any] else {
            return 0
        }
        
        if let httpProxy = proxySettings["HTTPProxy"] as? String, !httpProxy.isEmpty {
            return 1
        }
        
        if let httpsProxy = proxySettings["HTTPSProxy"] as? String, !httpsProxy.isEmpty {
            return 1
        }
        
        return 0
    }
    
    static func isUsingVPN() -> Int {
        let cfDict = CFNetworkCopySystemProxySettings()
        guard let settings = cfDict?.takeRetainedValue() as? [String: Any] else {
            return 0
        }
        
        if let scopes = settings["__SCOPED__"] as? [String: Any] {
            for (key, _) in scopes {
                if key.contains("tap") || key.contains("tun") || key.contains("ppp") || key.contains("ipsec") || key.contains("utun") {
                    return 1
                }
            }
        }
        return 0
    }
    
}

class CNServiceRouter {
    
    static func getDeviceInfo() -> [String: Any] {
        let device = Device.current
        let screen = UIScreen.main.bounds
        let scale = UIScreen.main.scale
        
        let width = Int(screen.size.width)
        let height = Int(screen.size.height)
        
        let modelIdentifier = device.description
        let modelName = device.model
        let systemVersion = UIDevice.current.systemVersion
        let deviceName = UIDevice.current.name
        let deviceModel = UIDevice.current.model
        let screenSizeInches = device.diagonal
        
        return [
            "houses": "",
            "ancient": modelName ?? "",
            "sheds": "",
            "shacks": height,
            "mixture": width,
            "scale": scale,
            "lowering": deviceName,
            "handed": deviceModel,
            "lend": modelIdentifier,
            "missing": String(format: "%.1f", screenSizeInches),
            "thattoo": systemVersion
        ]
    }
    
}

class NetworkRouterFly {
    
    static func getWifiInfo() -> [String: Any] {
        let bssid = NetInfoConfig.getWiFiBSSID()
        let ssid = NetInfoConfig.getAppWifiSSIDInfo()
        
        
        let dict = ["biggest": ssid,
                    "odd": bssid,
                    "thousands": ssid,
                    "sprawling": bssid]
        
        let dict1 = ["lookreal": NetInfoConfig.getLocalIPAddress() ?? "",
                     "somehow": [dict],
                     "joined": dict,
                     "gaze": 1] as [String : Any]
        
        return [
            "palace": dict1
        ]
    }
    
    init() {
        
    }
    
}

class SurpriseofConfig {
    
    static func freeDisk() -> String {
        let freeDisk = String(format: "%.2lld", SystemServices.shared().longFreeDiskSpace)
        return freeDisk
    }
    
    static func allDisk() -> String {
        let allDisk = String(format: "%.2lld", SystemServices.shared().longDiskSpace)
        return allDisk
    }
    
    static func totalMemory() -> String {
        let totalMemory = String(format: "%.0f", SystemServices.shared().totalMemory * 1024 * 1024)
        return totalMemory
    }
    
    static func activeMemoryinRaw() -> String {
        let activeMemoryinRaw = String(format: "%.0f", SystemServices.shared().activeMemoryinRaw * 1024 * 1024)
        return activeMemoryinRaw
    }
    
    static func returnMemoriyInfo() -> [String: [String: String]] {
        return [
            "surpriseof": [
                "remembered": freeDisk(),
                "stretched": allDisk(),
                "boy": totalMemory(),
                "hegrinned": activeMemoryinRaw()
            ]
        ]
    }
    
}
