//
//  RoutePhoneViewController.swift
//  credibot
//
//  Created by Ava Martin on 2025/6/8.
//

import UIKit
import KRProgressHUD
import RxRelay

class RoutePhoneViewController: BaseViewController {
    
    var productID: String = ""
    
    var listArray = BehaviorRelay<[topickModel]?>(value: nil)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(RoutePesoViewCell.self, forCellReuseIdentifier: "RoutePesoViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setTitle("Next step", for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.pix(), weight: .bold)
        nextBtn.backgroundColor = UIColor.init(colorHex: "#050647")
        nextBtn.layer.cornerRadius = 25.pix()
        nextBtn.layer.masksToBounds = true
        return nextBtn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(colorHex: "#F1F5F9")
        view.addSubview(backBtn)
        view.addSubview(nameLabel)
        nameLabel.text = "Contact Information"
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
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15.pix())
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-85.pix())
        }
        
        view.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20.pix())
            make.size.equalTo(CGSize(width: 345.pix(), height: 50.pix()))
        }
        
        self.listArray.compactMap { $0 }.asObservable().bind(to: tableView.rx.items(cellIdentifier: "RoutePesoViewCell", cellType: RoutePesoViewCell.self)) { row, model, cell in
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
        }.disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            Task {
                await self.getListiNFO()
            }
        }
    }

}

extension RoutePhoneViewController {
    
    private func getListiNFO() async {
        KRProgressHUD.show(withMessage: "loading...")
        let man = NetworkManager()
        let dict = ["test": productID]
        do {
           let result = try await man.request(.postData(endpoint: "/cbd/ashore", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            if wanted == "0" || wanted == "00" {
                let listArray = result.floated?.wander?.topick ?? []
                self.listArray.accept(listArray)
            }
            KRProgressHUD.dismiss()
        } catch  {
            KRProgressHUD.dismiss()
        }
    }
    
}
