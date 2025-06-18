//
//  StateMenuViewController.swift
//  credibot
//
//  Created by Ava Martin on 2025/6/8.
//

import UIKit
import KRProgressHUD
import RxRelay
import BRPickerView

class StateMenuViewController: BaseViewController {
    
    var listArray = BehaviorRelay<[traysModel]?>(value: nil)
    
    var productID: String = ""
    
    lazy var botView: AboutBotView = {
        let botView = AboutBotView()
        return botView
    }()
    
    var mixTuype: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.init(colorHex: "#F1F5F9")
        view.addSubview(backBtn)
        view.addSubview(nameLabel)
        nameLabel.text = "Personal Information"
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
        
        view.addSubview(botView)
        botView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(15.pix())
            make.left.right.bottom.equalToSuperview()
        }
        
        botView.tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            if let self = self, let listArray = self.listArray.value {
                let model = listArray[indexPath.row]
                let wares = model.wares ?? ""
                if wares == "mycbdl" {//normal
                    let cell = botView.tableView.cellForRow(at: indexPath) as! AboutBotNormalViewCell
                }else if wares == "mycbdk" {//enum
                    let cell = botView.tableView.cellForRow(at: indexPath) as! AboutBotSelectViewCell
                    let listArray = PickerHelper.showSinglePicker(dataSource: model.calledto ?? [])
                    configurePickerView(with: listArray, title: model.madetheir ?? "", cell: cell, mode: .province, model: model)
                }else if wares == "mycbdm" {//city
                    let cell = botView.tableView.cellForRow(at: indexPath) as! AboutBotSelectViewCell
                    let listArray = PickerHelper.showThreePicker(dataSource: DataAddressModelManager.shared.lastModel?.topick ?? [])
                    configurePickerView(with: listArray, title: "Select city", cell: cell, mode: .area, model: model)
                }
            }
        }).disposed(by: disposeBag)
        
        
        botView.nextBtnBlock = { [weak self] in
            guard let self = self else { return }
            guard let models = self.listArray.value else { return }
            var resultDict: [String: String] = ["test": productID]
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
            
        }
        
        mixTuype = String(SCSignalManager.getCurrentTime())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            Task {
                await self.getListDetailInfo()
            }
        }
    }
    
}

extension StateMenuViewController {
    
    private func saveInfo(to dict: [String: String]) async {
        KRProgressHUD.show(withMessage: "loading...")
        let man = NetworkManager()
        do {
            let result = try await man.request(.postData(endpoint: "/cbd/arriving", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            let likesnake = result.likesnake ?? ""
            if wanted == "0" || wanted == "00" {
                KRProgressHUD.dismiss()
                Task {
                    await self.stepInfo(with: productID, type: "5", cold: mixTuype, pollys: String(SCSignalManager.getCurrentTime()))
                    await self.getProdectDetailInfoToVc(to: productID)
                }
            }else {
                KRProgressHUD.showMessage(likesnake)
            }
        } catch  {
            KRProgressHUD.dismiss()
        }
    }
    
    private func getListDetailInfo() async {
        KRProgressHUD.show(withMessage: "loading...")
        let man = NetworkManager()
        let dict = ["test": productID, "child": "1"]
        do {
            let result = try await man.request(.postData(endpoint: "/cbd/looked", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            if wanted == "0" || wanted == "00" {
                let listArray = result.floated?.trays ?? []
                self.botView.listArray.accept(listArray)
                self.listArray.accept(listArray)
            }
            KRProgressHUD.dismiss()
        } catch  {
            KRProgressHUD.dismiss()
        }
    }
    
    func configurePickerView(with provinces: [BRProvinceModel], title: String, cell: AboutBotSelectViewCell, mode: BRAddressPickerMode, model: traysModel) {
        let addressPicker = BRAddressPickerView()
        addressPicker.pickerMode = mode
        addressPicker.title = title
        addressPicker.dataSourceArr = provinces
        addressPicker.selectIndexs = [0]
        
        addressPicker.resultBlock = { selectedProvince, selectedCity, selectedArea in
            if mode == .province {
                cell.imporyLabel.text = selectedProvince?.name ?? ""
                cell.imporyLabel.textColor = .black
                model.noisy = selectedProvince?.name ?? ""
                model.child = selectedProvince?.code ?? ""
            }else {
                let provice = selectedProvince?.name ?? ""
                let city = selectedCity?.name ?? ""
                let aere = selectedArea?.name ?? ""
                cell.imporyLabel.text = provice + "-" + city + "-" + aere
                cell.imporyLabel.textColor = .black
                model.noisy = provice + "-" + city + "-" + aere
            }
        }
        
        let pickerStyle = BRPickerStyle()
        pickerStyle.language = "en"
        addressPicker.pickerStyle = pickerStyle
        addressPicker.show()
    }
    
}
