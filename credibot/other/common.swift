//
//  common.swift
//  credibot
//
//  Created by 何康 on 2025/5/28.
//

import Foundation
import DeviceKit

import UIKit

class CommonParameter {
    
    var oneither: String
    var slide: String
    var banks: String
    var faces: String
    var forthe: String
    var cooler: String
    var noise: String
    var making: String
    
    init() {
        self.oneither = "i" + orignStr + superStr
        
        self.slide = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
        
        self.banks = ""
        
        self.faces = DeviceIdentifier.getIDFV()
        
        self.forthe = ""
        
        self.cooler = plageName + apiName
        
        self.noise = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        
        self.making = self.faces
        
        let dict = self.backModel()
        
        self.banks = dict["deviceName"] ?? ""
        
        self.forthe = dict["osVersion"] ?? ""
    }
    
    func toDictionary() -> [String: String] {
        return [
            "oneither": oneither,
            "slide": slide,
            "banks": banks,
            "faces": faces,
            "forthe": forthe,
            "cooler": cooler,
            "noise": noise,
            "making": making
        ]
    }
    
}

extension CommonParameter {
    
    private func backModel() -> [String: String] {
        let deviceName = Device.current.description
        let osVersion = Device.current.systemVersion ?? ""
        return [
            "deviceName": deviceName,
            "osVersion": osVersion
        ]
    }
    
}

class PhoneNumberManager {
    static let shared = PhoneNumberManager()
    var phoneNumber: String?

    private init() {}
}
