//
//  OngoingViewController.swift
//  credibot
//
//  Created by 何康 on 2025/5/29.
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            let productID = self.productID.value
            await getProdectDetailInfo(to: productID)
        }
    }

}

extension OngoingViewController {
    
    @objc private func btnClick() {
        self.navigationController?.popToRootViewController(animated: true)
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
    
}
