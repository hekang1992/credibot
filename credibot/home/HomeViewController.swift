//
//  HomeViewController.swift
//  credibot
//
//  Created by 何康 on 2025/5/27.
//

import UIKit
import MJRefresh
import KRProgressHUD

class HomeViewController: BaseViewController {
    
    lazy var drawerView: HomeView = {
        let drawerView = HomeView()
        return drawerView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(drawerView)
        drawerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.drawerView.scrollView.mj_header = MJRefreshHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.getHomeInfo()
            }
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await self.getHomeInfo()
        }
    }
    
}


extension HomeViewController {
    
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
                        changHomeUI(with: model)
                    }
                }else {
                    
                }
                //b
            }
        } catch  {
            
        }
        
    }
}

extension HomeViewController {
    
    private func changHomeUI(with model: skinnyModel) {
        self.drawerView.appNameLabel.text = model.turnedquickly ?? ""
        self.drawerView.descLabel.text = model.orbreaking ?? ""
    }
    
}
