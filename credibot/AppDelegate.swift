//
//  AppDelegate.swift
//  credibot
//
//  Created by 何康 on 2025/5/27.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        window?.rootViewController = FirstViewController()
        
        
        NotificationCenter.default.addObserver(self,
                                               selector:
                                                #selector(changeVc(_:)),
                                               name:
                                                NSNotification.Name("changeVc"),
                                               object:
                                                nil)
        
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        UIViewController.swizzleViewDidLoad()
        UIButton.swizzleSendAction()
        window?.makeKeyAndVisible()
        return true
    }

}

extension AppDelegate {
    
    @objc func changeVc(_ notification: Notification) {
        let needLogin = UserDefaults.standard.object(forKey: "token") as? String ?? ""
        window?.rootViewController = needLogin.isEmpty ? BaseNavigationController(rootViewController: LoginViewController()) : BaseNavigationController(rootViewController: CustomTabBarController())
    }
    
}

