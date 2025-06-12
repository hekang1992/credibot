//
//  deviceinfo.swift
//  credibot
//
//  Created by 何康 on 2025/6/12.
//

import UIKit
import Foundation

class BorkenConfig {
    
    static func isJailbroken() -> Int {
#if targetEnvironment(simulator)
        return 0
#else
        // 检查常见越狱文件路径
        let jailbreakFilePaths = [
            "/Applications/Cydia.app",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt",
            "/private/var/lib/apt/"
        ]
        
        for path in jailbreakFilePaths {
            if FileManager.default.fileExists(atPath: path) {
                return 1
            }
        }
        
        let testPath = "/private/jb_test.txt"
        do {
            try "test".write(toFile: testPath, atomically: true, encoding: .utf8)
            try FileManager.default.removeItem(atPath: testPath)
            return 1
        } catch {
            
        }
        
        if UIApplication.shared.canOpenURL(URL(string: "cydia://package/com.example.package")!) {
            return 1
        }
        
        return 0
#endif
    }
    
    
    static func isSimulator() -> Int {
#if targetEnvironment(simulator)
        return 1
#else
        return 0
#endif
    }
    
    static func systemUptime() -> String {
        let systemUptime = ProcessInfo.processInfo.systemUptime
        return String(format: "%.0f", systemUptime * 1000)
    }
    
}
