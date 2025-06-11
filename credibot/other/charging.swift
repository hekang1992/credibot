//
//  charging.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/6/11.
//

import UIKit

class DebugInfo {
    
    static func getLastTime() -> String {
        let lasttime = ProcessInfo.processInfo.systemUptime
        let loginDate = Date(timeIntervalSinceNow: -lasttime)
        let time = String(format: "%ld", Int(loginDate.timeIntervalSince1970 * 1000))
        return time
    }
    
    static func getAppBundleIdentifier() -> String? {
        return Bundle.main.bundleIdentifier
    }
    
    static func getBatteryPercentage() -> Int? {
        guard UIDevice.current.isBatteryMonitoringEnabled else {
            return nil
        }
        
        let batteryLevel = UIDevice.current.batteryLevel
        guard batteryLevel >= 0 else {
            return nil
        }
        
        return Int(batteryLevel * 100)
    }
    
    static func isCharging() -> Int {
        guard UIDevice.current.isBatteryMonitoringEnabled else {
            return 0
        }
        
        switch UIDevice.current.batteryState {
        case .charging, .full:
            return 1
        case .unplugged, .unknown:
            return 0
        @unknown default:
            return 0
        }
    }
    
}
