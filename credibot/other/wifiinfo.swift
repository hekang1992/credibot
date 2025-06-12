//
//  wifiinfo.swift
//  credibot
//
//  Created by 何康 on 2025/6/12.
//

import SystemConfiguration.CaptiveNetwork

class NetInfoConfig {
    
    static func getWiFiBSSID() -> String? {
        guard let interfaces = CNCopySupportedInterfaces() as? [String] else {
            return nil
        }
        
        for interface in interfaces {
            if let unsafeInterfaceData = CNCopyCurrentNetworkInfo(interface as CFString),
               let interfaceData = unsafeInterfaceData as? [String: AnyObject],
               let bssid = interfaceData[kCNNetworkInfoKeyBSSID as String] as? String {
                return bssid
            }
        }
        return nil
    }
    
}
