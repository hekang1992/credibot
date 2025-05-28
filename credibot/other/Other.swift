//
//  Other.swift
//  credibot
//
//  Created by 何康 on 2025/5/27.
//

import UIKit
import SnapKit

let screen_width = UIScreen.main.bounds.size.width
let screen_height = UIScreen.main.bounds.size.height

struct PhoneNumber {
    private let rawNumber: String
    let maskedNumber: String
    init(number: String) {
        self.rawNumber = number
        guard number.count >= 4 else {
            self.maskedNumber = number
            return
        }
        let prefix = String(number.prefix(2))
        let suffix = String(number.suffix(4))
        let maskCount = number.count - 6
        self.maskedNumber = prefix + String(repeating: "*", count: max(0, maskCount)) + suffix
    }
}

extension Double {
    func pix() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * screen_width)
    }
}

extension CGFloat {
    func pix() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * screen_width)
    }
}

extension Int {
    func pix() -> CGFloat {
        return CGFloat.init(CGFloat.init(self)/375.0 * screen_width)
    }
}

extension UIColor {
    convenience init?(colorHex: String) {
        let hexString = colorHex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        guard hexString.hasPrefix("#") else {
            return nil
        }
        let hexCode = hexString.dropFirst()
        guard hexCode.count == 6, let rgbValue = UInt64(hexCode, radix: 16) else {
            return nil
        }
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}

