//
//  OrderViewController.swift
//  credibot
//
//  Created by emma on 2025/5/27.
//

import UIKit
import RxSwift
import RxCocoa
import MJRefresh
import KRProgressHUD

class OrderViewController: BaseViewController {
    
    lazy var headView: OrderHeadView = {
        let headView = OrderHeadView()
        return headView
    }()
    
    lazy var emptyView: EmptyView = {
        let emptyView = EmptyView()
        emptyView.backgroundColor = .white
        return emptyView
    }()
    
    var flag: String = "4"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(RouteOrderListCell.self, forCellReuseIdentifier: "RouteOrderListCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    var modelArray = BehaviorRelay<[topickModel]?>(value: nil)
    
    var isShoeHead: Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        if isShoeHead {
            self.addHeadView()
        }
        
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            if isShoeHead {
                make.top.equalTo(nameLabel.snp.bottom).offset(15.pix())
            }else {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            }
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(5)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-5)
        }
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            Task {
                await self.getDataInfo(with: self.flag)
            }
        })
        
        headView.block1 = { [weak self] sloppy in
            guard let self = self else { return }
            Task {
                self.flag = sloppy
                await self.getDataInfo(with: sloppy)
            }
        }
        
        headView.block2 = { [weak self] sloppy in
            guard let self = self else { return }
            Task {
                self.flag = sloppy
                await self.getDataInfo(with: sloppy)
            }
        }
        
        headView.block3 = { [weak self] sloppy in
            guard let self = self else { return }
            Task {
                self.flag = sloppy
                await self.getDataInfo(with: sloppy)
            }
        }
        
        headView.block4 = { [weak self] sloppy in
            guard let self = self else { return }
            Task {
                self.flag = sloppy
                await self.getDataInfo(with: sloppy)
            }
        }
        
        self.modelArray.compactMap { $0 }.asObservable().bind(to: tableView.rx.items(cellIdentifier: "RouteOrderListCell", cellType: RouteOrderListCell.self)) { row, model, cell in
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.model.accept(model)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(topickModel.self).subscribe(onNext: { [weak self] model in
            let appid = model.women ?? 0
            Task {
                await self?.applyInfo(with: String(appid))
            }
        }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Task {
            await getDataInfo(with: self.flag)
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
    
}

extension OrderViewController {
    
    private func getDataInfo(with sloppy: String) async {
        KRProgressHUD.show(withMessage: "loading...")
        let man = NetworkManager()
        let dict = ["sloppy": sloppy]
        do {
            let result = try await man.request(.postData(endpoint: "/cbd/ennision", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            if wanted == "0" || wanted == "00" {
                if let model = result.floated {
                    let listArray = model.topick ?? []
                    if listArray.isEmpty {
                        self.view.addSubview(emptyView)
                        emptyView.snp.makeConstraints { make in
                            make.top.equalTo(headView.snp.bottom).offset(5)
                            make.left.right.equalToSuperview()
                            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-5)
                        }
                        emptyView.block = {
                            NotificationCenter.default.post(name: NSNotification.Name("changeVc"), object: nil)
                        }
                        self.modelArray.accept([])
                    }else {
                        self.emptyView.removeFromSuperview()
                        self.modelArray.accept(listArray)
                    }
                }
            }
            KRProgressHUD.dismiss()
            await self.tableView.mj_header?.endRefreshing()
        } catch {
            KRProgressHUD.dismiss()
            await self.tableView.mj_header?.endRefreshing()
        }
    }
    
}

extension OrderViewController {
    
    private func addHeadView() {
        view.addSubview(backBtn)
        view.addSubview(nameLabel)
        nameLabel.text = "Order"
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
    }
    
}
