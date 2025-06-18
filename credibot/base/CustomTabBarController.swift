//
//  CustomTabBarController.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/5/27.
//

import UIKit
import CoreLocation

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Configure tab bar items
        let tabs: [(vc: UIViewController, title: String, normalImage: String, selectedImage: String)] = [
            (HomeViewController(), "Home", "homenor", "homesel"),
            (OrderViewController(), "Order", "ordernor", "ordersel"),
            (CenterViewController(), "Mine", "centernor", "centersel")
        ]
        
        self.delegate = self
        
        viewControllers = tabs.map { item in
            let navController = BaseNavigationController(rootViewController: item.vc)
            navController.tabBarItem = UITabBarItem(
                title: item.title,
                image: UIImage(named: item.normalImage)?.withRenderingMode(.alwaysOriginal),
                selectedImage: UIImage(named: item.selectedImage)?.withRenderingMode(.alwaysOriginal)
            )
            return navController
        }
        
        // Configure tab bar appearance
        UITabBarItem.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.init(colorHex: "#A1A4AC")!],
            for: .normal
        )
        UITabBarItem.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.black],
            for: .selected
        )
    }
    
}

extension CustomTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let selectedIndex = tabBarController.viewControllers?.firstIndex(of: viewController) else {
            return true
        }
        switch selectedIndex {
        case 0:
            return true
        case 1:
            let result = canClockTab()
            if result == true {
                return true
            }else {
                showPermissionAlert()
                return false
            }
        case 2:
            let result = canClockTab()
            if result == true {
                return true
            }else {
                showPermissionAlert()
                return false
            }
        default:
            return true
        }
    }
    
    private func showPermissionAlert() {
        let alert = UIAlertController(
            title: "Access Denied",
            message: "To provide you with better service, we need to access your location information. Rest assured, your privacy and security are our top priority.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Setting", style: .default) { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString),
                  UIApplication.shared.canOpenURL(settingsURL) else { return }
            UIApplication.shared.open(settingsURL)
        })
        present(alert, animated: true)
    }
    
    private func canClockTab() -> Bool {
        let model = DataHomeModelManager.shared.lastModel
        let grand = model?.coinage ?? 0
        if grand == 1 {
            let status = CLLocationManager().authorizationStatus
            if status == .authorizedAlways || status == .authorizedWhenInUse {
                return true
            }else {
                return false
            }
        }else {
            return true
        }
    }
    
}
