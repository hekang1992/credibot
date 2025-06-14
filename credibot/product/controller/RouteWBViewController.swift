//
//  RouteWBViewController.swift
//  credibot
//
//  Created by Ava Martin on 2025/6/8.
//

import UIKit
import KRProgressHUD
import RxRelay
import BRPickerView

class RouteWBViewController: BaseViewController {
    
    var listArrayModel = BehaviorRelay<[traysModel]?>(value: nil)
    
    var model = BehaviorRelay<traysModel?>(value: nil)
    
    var productID: String = ""
    
    var flag = "0"
    
    var bindTie: String = ""
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 25.pix()
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = .white
        return bgView
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
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "drawerimge")
        return logoImageView
    }()
    
    lazy var walletBtn: UIButton = {
        let walletBtn = UIButton(type: .custom)
        walletBtn.setTitle("E-wallet", for: .normal)
        walletBtn.setTitleColor(.black, for: .normal)
        walletBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        walletBtn.contentHorizontalAlignment = .left
        return walletBtn
    }()
    
    lazy var bankBtn: UIButton = {
        let bankBtn = UIButton(type: .custom)
        bankBtn.setTitle("Bank", for: .normal)
        bankBtn.setTitleColor(.init(colorHex: "#999999"), for: .normal)
        bankBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        bankBtn.contentHorizontalAlignment = .left
        return bankBtn
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = .init(colorHex: "#000000")
        return lineView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "*After your confirmation,this account will be used as a receipt account to receive the funds*"
        titleLabel.textAlignment = .left
        titleLabel.textColor = UIColor.init(colorHex: "#FF0000")
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return titleLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(AboutBotNormalViewCell.self, forCellReuseIdentifier: "AboutBotNormalViewCell")
        tableView.register(AboutBotSelectViewCell.self, forCellReuseIdentifier: "AboutBotSelectViewCell")
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
        
        view.backgroundColor = UIColor.init(colorHex: "#F1F5F9")
        view.addSubview(backBtn)
        view.addSubview(nameLabel)
        nameLabel.text = "Payment Information"
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
        
        
        view.addSubview(bgView)
        view.addSubview(logoImageView)
        view.addSubview(nextBtn)
        
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(15.pix())
            make.top.equalTo(nameLabel.snp.bottom).offset(25.pix())
            make.bottom.equalToSuperview().offset(-85.pix())
        }
        logoImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-30.pix())
            make.top.equalTo(nameLabel.snp.bottom).offset(10.pix())
            make.size.equalTo(CGSize(width: 55.pix(), height: 55.pix()))
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20.pix())
            make.size.equalTo(CGSize(width: 345.pix(), height: 50.pix()))
        }
        
        bgView.addSubview(walletBtn)
        bgView.addSubview(lineView)
        bgView.addSubview(bankBtn)
        bindTie = String(SCSignalManager.getCurrentTime())
        walletBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25.pix())
            make.left.equalToSuperview().offset(15.pix())
            make.size.equalTo(CGSize(width: 60.pix(), height: 16.pix()))
        }
        
        lineView.snp.makeConstraints { make in
            make.centerY.equalTo(walletBtn)
            make.left.equalTo(walletBtn.snp.right).offset(15.pix())
            make.height.equalTo(1.pix())
            make.width.equalTo(10.pix())
        }
        
        bankBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(25.pix())
            make.left.equalTo(lineView.snp.right).offset(15.pix())
            make.size.equalTo(CGSize(width: 60.pix(), height: 16.pix()))
        }
        
        walletBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            walletBtn.setTitleColor(.black, for: .normal)
            bankBtn.setTitleColor(.init(colorHex: "#999999"), for: .normal)
            self.model.accept(self.listArrayModel.value?[0])
            self.flag = "0"
        }).disposed(by: disposeBag)
        
        bankBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            bankBtn.setTitleColor(.black, for: .normal)
            walletBtn.setTitleColor(.init(colorHex: "#999999"), for: .normal)
            self.model.accept(self.listArrayModel.value?[1])
            self.flag = "1"
        }).disposed(by: disposeBag)
        
        bgView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25.pix())
            make.left.equalToSuperview().offset(15.pix())
        }
        
        bgView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(60.pix())
            make.left.right.equalToSuperview()
            make.bottom.equalTo(titleLabel.snp.top).offset(-5.pix())
        }
        
        self.model.compactMap { $0?.trays ?? [] }.bind(to: tableView.rx.items) { tableView, index, model in
            let type = model.wares ?? ""
            let name = model.madetheir ?? ""
            let placeName = model.testament ?? ""
            let passed = model.passed ?? 0
            let noisy = model.noisy ?? ""
            if type == "mycbdk" || type == "mycbdm" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "AboutBotSelectViewCell", for: IndexPath(row: index, section: 0)) as? AboutBotSelectViewCell {
                    cell.nameLabel.text = name
                    cell.selectionStyle = .none
                    cell.backgroundColor = .clear
                    cell.imporyLabel.text = noisy.isEmpty ? placeName : noisy
                    cell.imporyLabel.textColor = noisy.isEmpty ? UIColor.init(colorHex: "#999999"): .black
                    return cell
                }
            }else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "AboutBotNormalViewCell", for: IndexPath(row: index, section: 0)) as? AboutBotNormalViewCell {
                    cell.nameLabel.text = name
                    cell.phoneTx.placeholder = placeName
                    cell.selectionStyle = .none
                    cell.backgroundColor = .clear
                    if passed == 1 {
                        cell.phoneTx.keyboardType = .numberPad
                    }else {
                        cell.phoneTx.keyboardType = .default
                    }
                    cell.phoneTx.text = ""
                    cell.phoneTx.rx.text
                        .subscribe(onNext: { text in
                            model.noisy = text
                        })
                        .disposed(by: self.disposeBag)
                    if noisy.isEmpty {
                        cell.phoneTx.placeholder = placeName
                    }else {
                        cell.phoneTx.text = noisy
                    }
                    model.noisy = noisy.isEmpty ? "" : noisy
                    return cell
                }
            }
            return UITableViewCell()
        }.disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            if let model = self.model.value?.trays?[indexPath.row] {
                let wares = model.wares ?? ""
                if wares == "mycbdl" {
                    let cell = tableView.cellForRow(at: indexPath) as! AboutBotNormalViewCell
                }else {
                    let cell = tableView.cellForRow(at: indexPath) as! AboutBotSelectViewCell
                    let listArray = PickerHelper.showSinglePicker(dataSource: model.calledto ?? [])
                    configurePickerView(with: listArray, title: "Select", cell: cell, model: model)
                }
            }
        }).disposed(by: disposeBag)
        
        
        nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self, let models = self.model.value?.trays else { return }
            var tobuy: String = "1"
            if flag == "0" {
                tobuy = "1"
            }else {
                tobuy = "2"
            }
            
            var resultDict: [String: String] = ["test": productID, "tobuy": tobuy]
            for model in models {
                guard let key = model.wanted else { continue }
                let value: String
                if model.wares == "mycbdl" || model.wares == "mycbdm" {
                    value = model.noisy ?? ""
                } else {
                    value = model.child ?? ""
                }
                resultDict[key] = value
            }
            Task {
                await self.saveInfo(to: resultDict)
            }
        }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            Task {
                await self.getMessageInfo()
            }
        }
    }
    
    private func saveInfo(to dict: [String: String]) async {
        KRProgressHUD.show(withMessage: "loading...")
        let man = NetworkManager()
        do {
            let result = try await man.request(.postData(endpoint: "/cbd/falling", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            let likesnake = result.likesnake ?? ""
            if wanted == "0" || wanted == "00" {
                KRProgressHUD.dismiss()
                Task {
                    await self.stepInfo(with: productID, type: "8", cold: bindTie, pollys: String(SCSignalManager.getCurrentTime()))
                    await self.getProdectDetailInfoToVc(to: productID)
                }
            }else {
                KRProgressHUD.showMessage(likesnake)
            }
        } catch  {
            KRProgressHUD.dismiss()
        }
    }
    
    func configurePickerView(with provinces: [BRProvinceModel], title: String, cell: AboutBotSelectViewCell, model: traysModel) {
        let addressPicker = BRAddressPickerView()
        addressPicker.pickerMode = .province
        addressPicker.title = title
        addressPicker.dataSourceArr = provinces
        addressPicker.selectIndexs = [0]
        
        addressPicker.resultBlock = { selectedProvince, selectedCity, selectedArea in
            cell.imporyLabel.text = selectedProvince?.name ?? ""
            cell.imporyLabel.textColor = .black
            model.child = selectedProvince?.code ?? ""
            model.noisy = selectedProvince?.name ?? ""
        }
        
        let pickerStyle = BRPickerStyle()
        pickerStyle.language = "en"
        addressPicker.pickerStyle = pickerStyle
        addressPicker.show()
    }
    
}

extension RouteWBViewController {
    
    private func getMessageInfo() async {
        KRProgressHUD.show(withMessage: "loading...")
        let man = NetworkManager()
        let dict = ["cine": "0", "enormouscameras": "1", "test": productID]
        do {
            let result = try await man.request(.postData(endpoint: "/cbd/quicka", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            if wanted == "0" || wanted == "00" {
                let trays = result.floated?.trays ?? []
                self.listArrayModel.accept(trays)
                self.model.accept(trays[0])
            }
            KRProgressHUD.dismiss()
        } catch  {
            KRProgressHUD.dismiss()
        }
    }
    
    
    
}
