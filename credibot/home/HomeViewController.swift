//
//  HomeViewController.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/5/27.
//

import UIKit
import MJRefresh
import KRProgressHUD
import RxSwift
import CoreLocation

class HomeViewController: BaseViewController {
    
    lazy var drawerView: HomeView = {
        let drawerView = HomeView()
        drawerView.isHidden = true
        return drawerView
    }()
    
    lazy var childView: HomeChildView = {
        let childView = HomeChildView()
        childView.isHidden = true
        return childView
    }()
    
    private var model: skinnyModel?
    
    private var floatModel: floatedModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(drawerView)
        drawerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(childView)
        childView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.drawerView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.getHomeInfo()
            }
        })
        
        ///apply
        self.drawerView.applyBlock = { [weak self] in
            guard let self = self else { return }
            //judge_location
            let grand = self.floatModel?.coinage ?? 0
            if grand == 1 {
                let status = CLLocationManager().authorizationStatus
                if status == .authorizedAlways || status == .authorizedWhenInUse {
                    setAppIpoInfo()
                }else {
                    showSettingsAlert(from: self)
                    return
                }
            }else {
                setAppIpoInfo()
            }
        }
        
        ///seaall
        self.drawerView.selAllBlock = { [weak self] in
            guard let self = self else { return }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.getHomeInfo()
        }
        setAppInfo()
    }
    
    private func setAppIpoInfo() {
        setAppInfo()
        if let productID = self.model?.grabbed {
            Task {
                await self.applyInfo(with: String(productID))
            }
            
        }
    }
    
    private func setAppInfo() {
        let locationFetcher = LocationFetcher()
        locationFetcher.requestLocationOnce()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] location in
                if let self = self, let loc = location {
                    print("✅ 🚀 home ==== Rx success======：\(loc.latitude ?? 0), \(loc.longitude ?? 0), \(loc.address ?? "")")
                    Task {
                        await self.builtInfo(with: loc)
                    }
                } else {
                    print("❌ Rx error")
                }
            })
            .disposed(by: disposeBag)
    }
    
}


extension HomeViewController {
    
    func showSettingsAlert(from vc: UIViewController, message: String? = "To provide you with better service, we need to access your location information. Rest assured, your privacy and security are our top priority.") {
        let alert = UIAlertController(title: "Access Denied", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Setting", style: .default) { _ in
            guard let settingsURL = URL(string: UIApplication.openSettingsURLString),
                  UIApplication.shared.canOpenURL(settingsURL) else { return }
            UIApplication.shared.open(settingsURL)
        })
        vc.present(alert, animated: true)
    }
    
    private func builtInfo(with model: LocationModel) async {
        let man = NetworkManager()
        let dict = ["jerry": model.proviceCode ?? "",
                    "masses": model.countryCode ?? "",
                    "stored": model.country ?? "",
                    "boards": model.latitude ?? 0.0,
                    "false": model.longitude ?? 0.0,
                    "built": model.address ?? "",
                    "holding": model.latitude ?? 0.0,
                    "oftimber": model.longitude ?? 0.0,
                    "joists": model.city ?? ""] as [String : Any]
        do {
            let _ = try await man.request(.postData(endpoint: "/cbd/themcoughed", parameters: dict), responseType: BaseModel.self)
        } catch  {
            
        }
        
        Task {
            await showDeviceInfo()
        }
        
    }
    
    private func showDeviceInfo() async {
        let dict1 = CFPrivateEntry.returnDict()
        let dict2 = SCSignalManager.returnDict()
        let dict3 = CNServiceRouter.getDeviceInfo()
        let dict4 = NetworkRouterFly.getWifiInfo()
        let dict5 = SurpriseofConfig.returnMemoriyInfo()
        
        let dictionaries = [dict1, dict2, dict3, dict4, dict5]
        let combinedDict = dictionaries.reduce(into: [String: Any]()) { result, dict in
            result.merge(dict) { (current, _) in current }
        }
//        print("✈️ combinedDict==========\(combinedDict)")
        
        let jsonStr = paraToBaseStr(combinedDict)
        
        let man = NetworkManager()
        let dict = ["floated": jsonStr]
        do {
            let _ = try await man.request(.postData(endpoint: "/cbd/where", parameters: dict as [String : Any]), responseType: BaseModel.self)
        } catch  {
            
        }
        
    }
    
    private func paraToBaseStr(_ dict: [String: Any]) -> String? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dict)
            let base64EncodedString = jsonData.base64EncodedString()
            return base64EncodedString
        } catch {
            return nil
        }
    }
    
    private func applyInfo(with product: String) async {
        let dict = ["test": product,
                    "Valid": "0",
                    "audience": "1",
                    "invited": "1"]
        KRProgressHUD.show(withMessage: "loading...")
        let man = NetworkManager()
        do {
            let result = try await man.request(.postData(endpoint: "/cbd/anyones", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            if wanted == "0" || wanted == "00" {
                let admiration = result.floated?.admiration ?? ""
                if admiration.contains(personalizedUrl) && admiration.contains(PRODUCT_DETAIL_PAGE) {
                    let dict = SchemeUrlParameter.getParameters(from: admiration) ?? [:]
                    let ongVc = OngoingViewController()
                    let productID = dict["test"] ?? ""
                    ongVc.productID.accept(productID)
                    self.navigationController?.pushViewController(ongVc, animated: true)
                }else {
                    let webVc = RouteWebViewController()
                    let commonDict = CommonParameter().toDictionary()
                    let apiUrl = URLParameterHelper.appendQueryParameters(to: admiration, parameters: commonDict)!
                    webVc.pageUrl = apiUrl
                    self.navigationController?.pushViewController(webVc, animated: true)
                }
            }
            KRProgressHUD.dismiss()
        } catch  {
            KRProgressHUD.dismiss()
        }
    }
    
    private func getHomeInfo() async {
        KRProgressHUD.show(withMessage: "loading...")
        let man = NetworkManager()
        let dict = ["asfar": "1",
                    "chcek": "0",
                    "indignantly": "home"]
        do {
            let result = try await man.request(.getData(endpoint: "/cbd/darkness", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            if wanted == "0" || wanted == "00" {
                self.floatModel = result.floated
                if let lost = floatModel?.lost,
                    let child = lost.child,
                    child == "mycbde" {
                    self.childView.isHidden = false
                    self.drawerView.isHidden = true
                }else if let wriggled = result.floated?.wriggled,
                         let child = wriggled.child,
                         child == "mycbdb" {
                    if let model = wriggled.skinny?.first {
                        self.model = model
                        self.childView.isHidden = true
                        self.drawerView.isHidden = false
                        changHomeUI(with: model)
                    }
                }
            }
            KRProgressHUD.dismiss()
            await self.drawerView.scrollView.mj_header?.endRefreshing()
        } catch  {
            KRProgressHUD.dismiss()
            await self.drawerView.scrollView.mj_header?.endRefreshing()
        }
        
    }
}

extension HomeViewController {
    
    private func changHomeUI(with model: skinnyModel) {
        self.drawerView.appNameLabel.text = model.turnedquickly ?? ""
        self.drawerView.descLabel.text = model.orbreaking ?? ""
        self.drawerView.moneyLabel.text = model.clapping ?? ""
        let dropping = model.dropping ?? ""
        let days = dropping.split(separator: "-").map { String($0) }
        let dw = model.legs ?? ""
        if days.count == 2 {
            self.drawerView.minLabel.text = "\(days.first ?? "")\(dw)"
            self.drawerView.maxLabel.text = "\(days.last ?? "")\(dw)"
        }
        self.drawerView.rate1Label.text = model.juggled ?? ""
        self.drawerView.rate2Label.text = (model.throwing ?? "") + (model.loanRateUnit ?? "")
        
    }
    
}
