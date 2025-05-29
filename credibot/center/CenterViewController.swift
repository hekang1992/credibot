//
//  CenterViewController.swift
//  credibot
//
//  Created by emma on 2025/5/27.
//

import UIKit

class CenterViewController: BaseViewController {
    
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
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
