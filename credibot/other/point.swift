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


class GetColorConfig: NSObject {
    private static let defaultFont = UIFont.systemFont(ofSize: 12.pix(), weight: .regular)
    private static let defaultColorHex = "#faeda5"
    private static let defaultColor = UIColor(colorHex: defaultColorHex) ?? .white
    static func attributedString(for count: String?,
                                 in fullText: String,
                                 colorHex: String? = nil) -> NSAttributedString {
        let countValue = count ?? ""
        let attributedString = NSMutableAttributedString(string: fullText)
        
        guard let range = fullText.range(of: countValue) else {
            return attributedString
        }
        
        let nsRange = NSRange(range, in: fullText)
        let color = colorHex.flatMap { UIColor(colorHex: $0) } ?? defaultColor
        
        attributedString.addAttributes([
            .foregroundColor: color,
            .font: defaultFont
        ], range: nsRange)
        
        return attributedString
    }
}
