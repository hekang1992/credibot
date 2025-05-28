//
//  BaseViewController.swift
//  credibot
//
//  Created by 何康 on 2025/5/27.
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
}

class BaseViewController: UIViewController {
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

