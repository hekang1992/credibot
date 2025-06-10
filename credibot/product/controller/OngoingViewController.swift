//
//  OngoingViewController.swift
//  credibot
//
//  Created by Ava Martin on 2025/5/29.
//

import UIKit
import RxRelay
import KRProgressHUD

class OngoingViewController: BaseViewController {
    
    var productID = BehaviorRelay<String>(value: "")
    
    lazy var listView: OngoingView = {
        let listView = OngoingView()
        return listView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(backBtn)
        view.addSubview(nameLabel)
        nameLabel.text = "Product Details"
        backBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 18.pix(), height: 26.pix()))
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
            make.left.equalToSuperview().offset(12.pix())
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backBtn.snp.centerY)
            make.centerX.equalToSuperview()
            make.height.equalTo(20.pix())
        }
        
        backBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(30.pix())
            make.left.right.bottom.equalToSuperview()
        }
        
        listView.block = { [weak self] nextStr, index in
            Task {
                await self?.unlockPath(with: nextStr, index: index)
            }
        }
        
        listView.appleBlock = {
            Task {
                let productID = self.productID.value
                await self.getProdectDetailInfoToVc(to: productID)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            Task {
                let productID = self.productID.value
                await self.getProdectDetailInfo(to: productID)
            }
        }
    }
    
    @objc override func btnClick() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}

extension OngoingViewController {
    
    private func unlockPath(with nextStr: String, index: Int) async {
        let productID = self.productID.value
        switch nextStr {
        case "1":
            if index == 1 {
                asaiFacePage(productID: productID)
            }else {
                await getAhead(with: productID)
            }
            break
        case "2":
            if index == 1 {
                let pageVc = StateMenuViewController()
                pageVc.productID = productID
                self.navigationController?.pushViewController(pageVc, animated: true)
            }else {
                Task {
                    await self.getProductGoVc(to: productID)
                }
            }
            break
        case "3":
            if index == 1 {
                let pageVc = RouteMenuViewController()
                pageVc.productID = productID
                self.navigationController?.pushViewController(pageVc, animated: true)
            }else {
                Task {
                    await self.getProductGoVc(to: productID)
                }
            }
            break
        case "4":
            if index == 1 {
                let pageVc = RoutePhoneViewController()
                pageVc.productID = productID
                self.navigationController?.pushViewController(pageVc, animated: true)
            }else {
                Task {
                    await self.getProductGoVc(to: productID)
                }
            }
            break
        case "5":
            if index == 1 {
                let pageVc = RouteWebViewController()
                pageVc.productID = productID
                self.navigationController?.pushViewController(pageVc, animated: true)
            }else {
                Task {
                    await self.getProductGoVc(to: productID)
                }
            }
            break
        default:
            break
        }
    }
    
    
    
    private func getProdectDetailInfo(to productID: String) async {
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
                    self.listView.model.accept(model)
                }
            }
            KRProgressHUD.dismiss()
        } catch {
            KRProgressHUD.dismiss()
        }
    }
    
    private func getProductGoVc(to productID: String) async {
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
                        await getAhead(with: productID)
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
                        let pageVc = RouteWebViewController()
                        pageVc.productID = productID
                        self.navigationController?.pushViewController(pageVc, animated: true)
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
    
    
    
}
