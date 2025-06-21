//
//  RecommendViewController.swift
//  credibot
//
//  Created by Ava Martin on 2025/6/8.
//

import UIKit
import RxSwift

class RecommendViewController: BaseViewController {
    
    var productID: String = ""
    
    var kycArray: [[String]] = []
    
    lazy var bgView: RecommendView = {
        let bgView = RecommendView()
        return bgView
    }()
    
    var min: String = ""
    var max: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.addSubview(backBtn)
        view.addSubview(nameLabel)
        nameLabel.text = "E-KYC"
        backBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 21.5.pix(), height: 31.pix()))
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
            make.left.equalToSuperview().offset(12.pix())
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backBtn.snp.centerY)
            make.centerX.equalToSuperview()
            make.height.equalTo(20.pix())
        }
        
        backBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(backBtn.snp.bottom).offset(15.pix())
        }
        
        bgView.tableView.delegate = self
        bgView.tableView.dataSource = self
        
        bgView.tableView.reloadData()
        
        min = String(SCSignalManager.getCurrentTime())
        
    }
    
}

extension RecommendViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.pix()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let titles = kycArray.flatMap { $0 }
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecommendCell", for: indexPath) as! RecommendCell
        let titles = kycArray.flatMap { $0 }
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.titleLabel.text = titles[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let titles = kycArray.flatMap { $0 }
        
        let type = titles[indexPath.section]
        
        let pageVc = RecommendStepViewController()
        pageVc.type = type
        pageVc.productID = productID
        self.navigationController?.pushViewController(pageVc, animated: true)
        max = String(SCSignalManager.getCurrentTime())
        Task {
            await stepInfo(with: productID, type: "2", cold: min, pollys: max)
        }
        
    }
    
    
    
}
