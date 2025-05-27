//
//  Other.swift
//  credibot
//
//  Created by 何康 on 2025/5/27.
//

import UIKit

let screen_width = UIScreen.main.bounds.size.width
let screen_height = UIScreen.main.bounds.size.height

var needLogin: Bool {
    (UserDefaults.standard.object(forKey: "token") as? String)?.isEmpty == false
}
