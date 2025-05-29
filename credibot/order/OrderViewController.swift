//
//  OrderViewController.swift
//  credibot
//
//  Created by 何康 on 2025/5/27.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh

class OrderViewController: BaseViewController {
    
    lazy var headView: OrderHeadView = {
        let headView = OrderHeadView()
        return headView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-5)
        }
        
        self.tableView.mj_header = MJRefreshHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            getDataInfo()
        })
        
        getDataInfo()
    }

}

extension OrderViewController {
    
    private func getDataInfo() {
        
    }
    
}
