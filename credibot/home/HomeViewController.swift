//
//  HomeViewController.swift
//  credibot
//
//  Created by emma on 2025/5/27.
//

import UIKit
import MJRefresh
import KRProgressHUD

class HomeViewController: BaseViewController {
    
    lazy var drawerView: HomeView = {
        let drawerView = HomeView()
        return drawerView
    }()
    
   private var model: skinnyModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(drawerView)
        drawerView.snp.makeConstraints { make in
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
            if let productID = self.model?.grabbed {
                
                Task {
                    await self.applyInfo(with: String(productID))
                }
                
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
    }
    
}


extension HomeViewController {
    
    private func applyInfo(with product: String) async {
        let dict = ["test": product,
                    "Valid": "0",
                    "audience": "1",
                    "invited": "1"]
        KRProgressHUD.showMessage("loading...")
        let man = NetworkManager()
        do {
            let result = try await man.request(.postData(endpoint: "/cbd/anyones", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            if wanted == "0" || wanted == "00" {
//                cbd://my.my.app/xwatermelonS?test=2
                let admiration = result.floated?.admiration ?? ""
                
            }
        } catch  {
            
        }
    }
    
    private func getHomeInfo() async {
        KRProgressHUD.showMessage("loading...")
        let man = NetworkManager()
        let dict = ["asfar": "1",
                    "chcek": "0",
                    "indignantly": "home"]
        do {
            let result = try await man.request(.getData(endpoint: "/cbd/darkness", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            if wanted == "0" || wanted == "00" {
                //a
                if let wriggled = result.floated?.wriggled,
                    let child = wriggled.child,
                    child == "mycbdb"  {
                    if let model = wriggled.skinny?.first {
                        self.model = model
                        changHomeUI(with: model)
                    }
                }else {
                    
                }
                //b
            }
            await self.drawerView.scrollView.mj_header?.endRefreshing()
        } catch  {
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
