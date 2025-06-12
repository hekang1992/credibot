//
//  Other.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/5/27.
//

import UIKit
import SnapKit
import AdSupport
import KeychainAccess
import KRProgressHUD

let orignStr = "o"
let superStr = "s"

let plageName = "credi"
let apiName = "botapi"

let lastSter = "pp/"

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

extension UIControl {
    
    static func swizzleSendAction() {
        guard let originalMethod = class_getInstanceMethod(UIControl.self, #selector(sendAction(_:to:for:))),
              let swizzledMethod = class_getInstanceMethod(UIControl.self, #selector(my_sendAction(_:to:for:))) else {
            return
        }
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
    @objc func my_sendAction(_ action: Selector, to target: Any?, for event: UIEvent?) {
        if let button = self as? UIButton {
            print("🚀 click: \(button)")
            if button.accessibilityIdentifier == "codeIntercept" {
                guard let phone = PhoneNumberManager.shared.phoneNumber, !phone.isEmpty else {
                    KRProgressHUD.showMessage("Please enter your phone number first")
                    return
                }
            }
            if button.accessibilityIdentifier == "loginIntercept" {
                guard let phone = PhoneNumberManager.shared.phoneNumber, !phone.isEmpty else {
                    KRProgressHUD.showMessage("Please enter your phone number first")
                    return
                }
                guard let code = PhoneNumberManager.shared.codeNumber, !code.isEmpty else {
                    KRProgressHUD.showMessage("Please enter your code number first")
                    return
                }
            }
        }
        my_sendAction(action, to: target, for: event)
    }
}

class DeviceIdentifier {
    
    private static let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "com.credibot.app")
    private static let idfvKey = "device_idfv"
    
    static func getIDFV() -> String {
        if let saved = try? keychain.get(idfvKey), !saved.isEmpty {
            return saved
        }
        
        let newIDFV = UIDevice.current.identifierForVendor?.uuidString ?? UUID().uuidString
        
        try? keychain.set(newIDFV, key: idfvKey)
        
        return newIDFV
    }
    
    static func clearIDFV() {
        try? keychain.remove(idfvKey)
    }
    
    static func getIDFA() -> String {
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
    
}

class URLParameterHelper {
    
    static func appendQueryParameters(to url: String,
                                      parameters: [String: String]) -> String? {
        
        guard var components = URLComponents(string: url) else {
            return nil
        }
        
        let queryItems = parameters.map {
            URLQueryItem(name: $0.key, value: $0.value)
        }
        
        components.queryItems = (components.queryItems ?? []) + queryItems
        return components.url?.absoluteString
    }
}

class StatusBarHelper {
    
    static let shared = StatusBarHelper()
    
    private init() {}
    
    var statusBarHeight: CGFloat {
        if #available(iOS 13.0, *) {
            return UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            return UIApplication.shared.statusBarFrame.height
        }
    }
    
    var topSafeAreaHeight: CGFloat {
        return UIApplication.shared.keyWindow?.safeAreaInsets.top ?? statusBarHeight
    }
    
    var bottomSafeAreaHeight: CGFloat {
        return UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
    }
    
    func statusBarHeight(for orientation: UIInterfaceOrientation) -> CGFloat {
        if orientation.isPortrait {
            return statusBarHeight
        } else {
            return hasNotch ? 0 : statusBarHeight
        }
    }
    
    var hasNotch: Bool {
        if #available(iOS 11.0, *) {
            let bottom = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0
            return bottom > 0
        } else {
            return false
        }
    }
    
    func navigationBarTotalHeight(navigationController: UINavigationController?) -> CGFloat {
        let navBarHeight = navigationController?.navigationBar.frame.height ?? 44
        return statusBarHeight + navBarHeight
    }
    
}

class SchemeUrlParameter {
    
   static func getParameters(from urlString: String) -> [String: String]? {
        guard let url = URL(string: urlString),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let queryItems = components.queryItems else {
            return nil
        }
        
        var parameters = [String: String]()
        for item in queryItems {
            parameters[item.name] = item.value
        }
        
        return parameters
    }
    
}
