//
//  CustomTabBarController.swift
//  credibot
//
//  Created by 何康 on 2025/5/27.
//

import UIKit

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
            [.foregroundColor: UIColor.gray],
            for: .normal
        )
        UITabBarItem.appearance().setTitleTextAttributes(
            [.foregroundColor: UIColor.black],
            for: .selected
        )
    }

}
