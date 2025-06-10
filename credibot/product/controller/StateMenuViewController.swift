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
                if wares == "mycbdl" {
                    let cell = botView.tableView.cellForRow(at: indexPath) as! AboutBotNormalViewCell
                }else if wares == "mycbdk" {
                    let cell = botView.tableView.cellForRow(at: indexPath) as! AboutBotSelectViewCell
                    let listArray = PickerHelper.showSinglePicker(dataSource: model.calledto ?? [])
                    configurePickerView(with: listArray, title: model.madetheir ?? "", cell: cell)
                }else if wares == "mycbdm" {
                    let cell = botView.tableView.cellForRow(at: indexPath) as! AboutBotSelectViewCell
                    let listArray = PickerHelper.showSinglePicker(dataSource: model.calledto ?? [])
                    configurePickerView(with: listArray, title: "", cell: cell)
                }
            }
        }).disposed(by: disposeBag)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            Task {
                await self.getDetailInfo()
            }
        }
    }
    
}

extension StateMenuViewController {
    
    private func getDetailInfo() async {
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
    
    func configurePickerView(with provinces: [BRProvinceModel], title: String, cell: AboutBotSelectViewCell) {
        let addressPicker = BRAddressPickerView()
        addressPicker.pickerMode = .province
        addressPicker.title = title
        addressPicker.dataSourceArr = provinces
        addressPicker.selectIndexs = [0]
        
        addressPicker.resultBlock = { selectedProvince, selectedCity, selectedArea in
            cell.imporyLabel.text = selectedProvince?.name ?? ""
            cell.imporyLabel.textColor = .black
        }

        let pickerStyle = BRPickerStyle()
        pickerStyle.language = "en"
        addressPicker.pickerStyle = pickerStyle
        addressPicker.show()
    }
    
}
