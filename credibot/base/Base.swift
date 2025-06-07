//
//  BaseViewController.swift
//  credibot
//
//  Created by emma on 2025/5/27.
//

import UIKit
import RxSwift

class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationBar.isHidden = true
        self.navigationBar.isTranslucent = false
        self.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    
}

class BaseViewController: UIViewController {
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setImage(UIImage(named: "backimge"), for: .normal)
        return backBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        nameLabel.textAlignment = .center
        nameLabel.textColor = .black
        return nameLabel
    }()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

}

extension UIViewController {
    static func swizzleViewDidLoad() {
        let original = class_getInstanceMethod(UIViewController.self, #selector(viewDidLoad))!
        let swizzled = class_getInstanceMethod(UIViewController.self, #selector(swizzled_viewDidLoad))!
        method_exchangeImplementations(original, swizzled)
    }

    @objc func swizzled_viewDidLoad() {
        print("✅ \(self) did load")
        swizzled_viewDidLoad()
    }
}

class BaseView: UIView {
    let disposeBag = DisposeBag()
}

class BaseViewCell: UITableViewCell {
    let disposeBag = DisposeBag()
}

class BaseCollectionViewCell: UICollectionViewCell {
    let disposeBag = DisposeBag()
}

