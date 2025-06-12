//
//  BaseViewController.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/5/27.
//

import UIKit
import RxSwift
import KRProgressHUD

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
    
    @objc func btnClick() {
        if let viewControllers = navigationController?.viewControllers {
            if let targetVC = viewControllers.first(where: { $0 is OngoingViewController }) {
                navigationController?.popToViewController(targetVC, animated: true)
            } else {
                navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    func getProdectDetailInfoToVc(to productID: String, type: String? = "") async {
        KRProgressHUD.show(withMessage: "loading...")
        let man = NetworkManager()
        let dict = ["test": productID,
                    "blades": "1",
                    "edges": "0"]
        do {
            let result =  try await man.request(.postData(endpoint: "/cbd/enough", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            if wanted == "0" || wanted == "00" {
                if let model = result.floated {
                    let wasthat = model.americans?.wasthat ?? ""
                    switch wasthat {
                    case NextType.mycbdf:
                        await self.getAhead(with: productID)
                        break
                    case NextType.mycbdg:
                        let pageVc = StateMenuViewController()
                        pageVc.productID = productID
                        self.navigationController?.pushViewController(pageVc, animated: true)
                        break
                    case NextType.mycbdh:
                        let pageVc = RouteMenuViewController()
                        pageVc.productID = productID
                        self.navigationController?.pushViewController(pageVc, animated: true)
                        break
                    case NextType.mycbdi:
                        let pageVc = RoutePhoneViewController()
                        pageVc.productID = productID
                        self.navigationController?.pushViewController(pageVc, animated: true)
                        break
                    case NextType.mycbdj:
                        let pageVc = RouteWBViewController()
                        pageVc.productID = productID
                        self.navigationController?.pushViewController(pageVc, animated: true)
                        break
                    case NextType.mycbdk:
                        if type == "1" {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                                let peolpeid = model.attendants?.chant ?? ""
                                Task {
                                    await self.sendToUplabubu(to: peolpeid, productID: productID)
                                }
                            }
                        }else {
                            btnClick()
                        }
                        break
                    default:
                        break
                    }
                }
            }
            KRProgressHUD.dismiss()
            
        } catch {
            KRProgressHUD.dismiss()
            
        }
    }
    
    func getAhead(with productID: String) async {
        KRProgressHUD.show(withMessage: "loading...")
        let man = NetworkManager()
        let dict = ["test": productID, "me": "1", "tell": "0"]
        do {
            let result =  try await man.request(.getData(endpoint: "/cbd/being", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            if wanted == "0" || wanted == "00" {
                if let model = result.floated {
                    let story = model.babies?.story ?? 0
                    let acting = model.acting ?? [[]]
                    story == 0 ? awaidPage(with: acting, productID: productID) : asaiFacePage(productID: productID)
                }
            }
            KRProgressHUD.dismiss()
        } catch {
            KRProgressHUD.dismiss()
        }
    }
    
    func awaidPage(with kycArray: [[String]], productID: String) {
        let pageVc = RecommendViewController()
        pageVc.productID = productID
        pageVc.kycArray = kycArray
        self.navigationController?.pushViewController(pageVc, animated: true)
    }
    
    func asaiFacePage(productID: String) {
        let pageVc = RecommendStepViewController()
        pageVc.productID = productID
        self.navigationController?.pushViewController(pageVc, animated: true)
    }
    
    private func sendToUplabubu(to adcId: String, productID: String) async {
        let h5Str = String(SCSignalManager.getCurrentTime())
        KRProgressHUD.show(withMessage: "loading...")
        let man = NetworkManager()
        let dict = ["corner": adcId,
                    "dressed": "1",
                    "european": "1",
                    "orderId": adcId]
        do {
            let result = try await man.request(.postData(endpoint: "/cbd/police", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            if wanted == "0" || wanted == "00" {
                let pageUrl = result.floated?.admiration ?? ""
                let webVc = RouteWebViewController()
                let commonDict = CommonParameter().toDictionary()
                let apiUrl = URLParameterHelper.appendQueryParameters(to: pageUrl, parameters: commonDict)!
                webVc.pageUrl = apiUrl
                self.navigationController?.pushViewController(webVc, animated: true)
                Task {
                    await self.stepInfo(with: productID, type: "9", cold: h5Str, pollys: String(SCSignalManager.getCurrentTime()))
                }
            }
            KRProgressHUD.dismiss()
        } catch  {
            KRProgressHUD.dismiss()
        }
    }
    
    func stepInfo(with productID: String,
                  type: String,
                  cold: String,
                  pollys: String) async {
        
        let dict = ["women": productID,
                    "sneeze": type,
                    "cold": cold,
                    "pollys": pollys]
        
        let locationFetcher: LocationFetcher = LocationFetcher()
        locationFetcher.requestLocationOnce()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { model in
                guard let model = model else { return }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    Task {
                        await ClickTracking.trackingAppInfo(model: model, para: dict)
                    }
                }
            }).disposed(by: disposeBag)
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

