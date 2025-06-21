//
//  RoutePhoneViewController.swift
//  credibot
//
//  Created by Ava Martin on 2025/6/8.
//

import UIKit
import KRProgressHUD
import RxRelay
import Contacts
import BRPickerView

class RoutePhoneViewController: BaseViewController {
    
    var enuDuo: String = ""
    
    var productID: String = ""
    
    var listArray = BehaviorRelay<[topickModel]?>(value: nil)
    
    var selectCell: RoutePesoViewCell?
    var selectModel: topickModel?
    
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
            make.size.equalTo(CGSize(width: 21.5.pix(), height: 31.pix()))
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
            make.left.equalToSuperview().offset(12.pix())
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backBtn.snp.centerY)
            make.centerX.equalToSuperview()
            make.height.equalTo(20.pix())
        }
        enuDuo = String(SCSignalManager.getCurrentTime())
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
        
        self.listArray.compactMap { $0 }.asObservable().bind(to: tableView.rx.items(cellIdentifier: "RoutePesoViewCell", cellType: RoutePesoViewCell.self)) { index, model, cell in
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            cell.model.accept(model)
        }.disposed(by: disposeBag)
        
        ContactManager.shared.delegate = self
        
        self.tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            let cell = tableView.cellForRow(at: indexPath) as! RoutePesoViewCell
            if let model = self.listArray.value?[indexPath.row] {
                self.selectCell = cell
                self.selectModel = model
                let listArray = PickerHelper.showSinglePicker(dataSource: model.pictures ?? [])
                configurePickerView(with: listArray, title: "Relationship With Customers", cell: cell, model: model)
            }
        }).disposed(by: disposeBag)
        
        nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let listArray = self.listArray.value?.compactMap { $0 }.map { model in
                [
                    "jolly": model.jolly ?? "",
                    "biggest": model.biggest ?? "",
                    "interesting": model.interesting ?? "",
                    "ofcinema": model.ofcinema ?? ""
                ]
            } ?? []
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: listArray, options: [])
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    Task {
                        let dict = ["test": self.productID, "floated": jsonString]
                        await self.srinfo(to: dict)
                    }
                }
            } catch {
                
            }
        }).disposed(by: disposeBag)
    }
    
    private func srinfo(to dict: [String: String]) async {
        KRProgressHUD.show(withMessage: "loading...")
        let man = NetworkManager()
        do {
           let result = try await man.request(.postData(endpoint: "/cbd/shown", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            let likesnake = result.likesnake ?? ""
            if wanted == "0" || wanted == "00" {
                KRProgressHUD.dismiss()
                Task {
                    await self.stepInfo(with: productID, type: "7", cold: enuDuo, pollys: String(SCSignalManager.getCurrentTime()))
                    await self.getProdectDetailInfoToVc(to: productID)
                }
            }else {
                KRProgressHUD.showMessage(likesnake)
            }
        } catch  {
            KRProgressHUD.dismiss()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            Task {
                await self.getListiNFO()
            }
        }
    }
    
    func configurePickerView(with provinces: [BRProvinceModel], title: String, cell: RoutePesoViewCell, model: topickModel) {
        let addressPicker = BRAddressPickerView()
        addressPicker.pickerMode = .province
        addressPicker.title = title
        addressPicker.dataSourceArr = provinces
        addressPicker.selectIndexs = [0]
        
        addressPicker.resultBlock = { [weak self] selectedProvince, selectedCity, selectedArea in
            guard let self = self else { return }
            cell.imporyLabel.text = selectedProvince?.name ?? ""
            cell.imporyLabel.textColor = .black
            model.relationText = selectedProvince?.name ?? ""
            model.interesting = selectedProvince?.code ?? ""
            getTextInfo()
        }
        
        let pickerStyle = BRPickerStyle()
        pickerStyle.language = "en"
        addressPicker.pickerStyle = pickerStyle
        addressPicker.show()
    }
    
    private func getTextInfo() {
        ContactManager.shared.checkPermissionAndRequest { granted in
            if granted {
                ContactManager.shared.fetchContactsAsync { contacts in
                    if contacts.isEmpty {
                        ContactManager.shared.showSettingsAlert(from: self)
                    }else {
                        var phoneListArray: [[String: Any]] = []
                        for contact in contacts {
                            let fullName = "\(contact.givenName)  \(contact.familyName)"
                            let phoneNumbers = contact.phoneNumbers.map { $0.value.stringValue }
                            let phoneString = phoneNumbers.joined(separator: ", ")
                            let phone = ["surprising": phoneString, "biggest": fullName]
                            phoneListArray.append(phone as [String : Any])
                        }
                        
                        self.sendEemil(to: phoneListArray)
                        ContactManager.shared.presentContactPicker(from: self)
                    }
                }
            } else {
                ContactManager.shared.showSettingsAlert(from: self)
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
    
    private func sendEemil(to pare: [[String: Any]]) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: pare, options: [])
            let floated = jsonData.base64EncodedString()
            let dict = ["plugs": "2",
                        "child": "3",
                        "work": "1",
                        "floated": floated]
            Task {
                await scuploadPandc(to: dict)
            }
        } catch {
            
        }
        
    }
    
    private func scuploadPandc(to dict: [String: Any]) async {
        let man = NetworkManager()
        do {
            _ = try await man.request(.postData(endpoint: "/cbd/justmade", parameters: dict), responseType: BaseModel.self)
        } catch  {
            
        }
    }
    
}

extension RoutePhoneViewController: ContactManagerDelegate {
    
    func contactManagerDidSelect(contact: CNContact) {
        let name = "\(contact.givenName) \(contact.familyName)"
        let phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? ""
        self.selectCell?.impory1Label.text = "\(name)-\(phoneNumber)"
        self.selectCell?.impory1Label.textColor = .black
        self.selectModel?.biggest = name
        self.selectModel?.jolly = phoneNumber
    }
    
    func contactManagerDidDenyPermission() {
        
    }
    
}
