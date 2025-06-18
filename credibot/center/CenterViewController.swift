//
//  CenterViewController.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/5/27.
//

import UIKit
import TYAlertController
import KRProgressHUD

let pro = "Products"
class CenterViewController: BaseViewController {
    
    var isClickSure: Bool = false
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var deleteBtn: UIButton = {
        let deleteBtn = UIButton(type: .custom)
        deleteBtn.adjustsImageWhenHighlighted = false
        deleteBtn.setImage(UIImage(named: "delaccountigme"), for: .normal)
        return deleteBtn
    }()
    
    lazy var centerLogoImageView: UIImageView = {
        let centerLogoImageView = UIImageView()
        centerLogoImageView.image = UIImage(named: "robot")
        return centerLogoImageView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = "Hello!"
        descLabel.textColor = UIColor.init(colorHex: "#000000")
        descLabel.font = UIFont.boldSystemFont(ofSize: 18)
        descLabel.textAlignment = .center
        return descLabel
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        let phone = UserDefaults.standard.object(forKey: "phone") as? String ?? ""
        phoneLabel.text = PhoneNumber(number: phone).maskedNumber
        phoneLabel.textColor = UIColor.init(colorHex: "#000000")
        phoneLabel.font = UIFont.boldSystemFont(ofSize: 14)
        phoneLabel.textAlignment = .center
        return phoneLabel
    }()
    
    let imageArray = ["orderimge", "emailimge", "privacyimge", "exitimge"]
    
    let titleArray = ["Order", "Online service", "Privacy agreement", "Exit the app"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.addSubview(deleteBtn)
        deleteBtn.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 44, height: 44))
        }
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(deleteBtn.snp.top).offset(21)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-5)
        }
        
        scrollView.addSubview(centerLogoImageView)
        centerLogoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 150, height: 150))
            make.top.equalToSuperview()
        }
        
        scrollView.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(centerLogoImageView.snp.bottom).offset(10)
            make.height.equalTo(24)
        }
        
        scrollView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descLabel.snp.bottom).offset(4)
            make.height.equalTo(15)
        }
        
        let dict = CommonParameter().toDictionary()
        
        var previousView: CenterListView? = nil
        for (index, item) in imageArray.enumerated() {
            let listView = CenterListView()
            scrollView.addSubview(listView)
            listView.tag = 10 + index
            listView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.click(to: 10 + index)
            }).disposed(by: disposeBag)
            listView.namelabel.text = titleArray[index]
            listView.logoImageView.image = UIImage(named: item)
            listView.snp.makeConstraints { make in
                make.height.equalTo(64)
                make.left.equalTo(scrollView)
                make.width.equalTo(screen_width)
                if index == 0 {
                    make.top.equalTo(phoneLabel.snp.bottom).offset(25)
                } else {
                    make.top.equalTo(previousView!.snp.bottom).offset(10)
                }
                if index == imageArray.count - 1 {
                    make.bottom.equalTo(scrollView).offset(-20)
                }
            }
            previousView = listView
        }
        
        deleteBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let deleteView = LogDeleteView(frame: self.view.bounds)
            let alertVc = TYAlertController(alert: deleteView, preferredStyle: .actionSheet)!
            self.present(alertVc, animated: true)
            
            deleteView.block1 = { [weak self] in
                guard let self = self else { return }
                if isClickSure {
                    self.dismiss(animated: true) {
                        Task {
                            await self.deleteInfo()
                        }
                    }
                }else {
                    KRProgressHUD.showMessage("Kindly confirm the account cancellation agreement before proceeding.")
                }
            }
            
            deleteView.block2 = { [weak self] in
                self?.dismiss(animated: true)
            }
            
            deleteView.block3 = { [weak self] grand in
                self?.isClickSure = grand
            }
            
        }).disposed(by: disposeBag)
        
    }
    
}

extension CenterViewController {
    
    private func click(to tag: Int) {
        if tag == 10 {
            let olistVc = OrderViewController()
            olistVc.flag = "4"
            olistVc.isShoeHead = true
            self.navigationController?.pushViewController(olistVc, animated: true)
        }else if tag == 11 {
            let pageUrl = baseurl + "/ninjaIrisBr"
            let webVc = RouteWebViewController()
            webVc.pageUrl = pageUrl
            self.navigationController?.pushViewController(webVc, animated: true)
        }else if tag == 12 {
            let pageUrl = baseurl + "/snailXyloph"
            let webVc = RouteWebViewController()
            webVc.pageUrl = pageUrl
            self.navigationController?.pushViewController(webVc, animated: true)
        }else if tag == 13 {
            let outView = LogoutView(frame: self.view.bounds)
            let alertVc = TYAlertController(alert: outView, preferredStyle: .actionSheet)!
            self.present(alertVc, animated: true)
            
            //out
            outView.block1 = { [weak self] in
                self?.dismiss(animated: true) {
                    Task {
                        await self?.exitInfo()
                    }
                }
            }
            
            //continu
            outView.block2 = { [weak self] in
                self?.dismiss(animated: true)
            }
            
        }
    }
    
    private func exitInfo() async {
        let man = NetworkManager()
        let phone = UserDefaults.standard.object(forKey: "phone") as? String ?? ""
        let dict = ["guard": "1", "engrossed": phone]
        KRProgressHUD.show(withMessage: "loading...")
        do {
            let result =  try await man.request(.getData(endpoint: "/cbd/mostastonishing", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            let likesnake = result.likesnake ?? ""
            if wanted == "0" || wanted == "00" {
                UserDefaults.standard.set("", forKey: "phone")
                UserDefaults.standard.set("", forKey: "token")
                UserDefaults.standard.synchronize()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    NotificationCenter.default.post(name: NSNotification.Name("changeVc"), object: nil)
                }
            }
            KRProgressHUD.showMessage(likesnake)
        } catch  {
            KRProgressHUD.dismiss()
        }
    }
    
    private func deleteInfo() async {
        let man = NetworkManager()
        let phone = UserDefaults.standard.object(forKey: "phone") as? String ?? ""
        let dict = ["mustnt": "1", "engrossed": phone]
        KRProgressHUD.show(withMessage: "loading...")
        do {
            let result =  try await man.request(.getData(endpoint: "/cbd/setssn", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            let likesnake = result.likesnake ?? ""
            if wanted == "0" || wanted == "00" {
                UserDefaults.standard.set("", forKey: "phone")
                UserDefaults.standard.set("", forKey: "token")
                UserDefaults.standard.synchronize()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    NotificationCenter.default.post(name: NSNotification.Name("changeVc"), object: nil)
                }
            }
            KRProgressHUD.showMessage(likesnake)
        } catch  {
            KRProgressHUD.dismiss()
        }
    }
    
}
