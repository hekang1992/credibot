//
//  LoginView.swift
//  credibot
//
//  Created by 何康 on 2025/5/27.
//

import UIKit
import RxGesture
import KAPinField

typealias codeBtnBlock = ((UIButton) -> Void)
typealias loginBtnBlock = (() -> Void)
class LoginView: BaseView {
    
    var block: codeBtnBlock?
    var block1: loginBtnBlock?
    var block2: loginBtnBlock?
    
    var isClickPrivacy: Bool = true
    
    lazy var topImageView: UIImageView = {
        let topImageView = UIImageView()
        topImageView.image = UIImage(named: "loginimge")
        return topImageView
    }()
    
    lazy var welcomeImageView: UIImageView = {
        let welcomeImageView = UIImageView()
        welcomeImageView.image = UIImage(named: "welcomeimge")
        return welcomeImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "logowel")
        return logoImageView
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.text = "PhoneNumber"
        phoneLabel.font = UIFont.boldSystemFont(ofSize: 18)
        phoneLabel.textAlignment = .center
        phoneLabel.textColor = UIColor.init(colorHex: "#000000")
        return phoneLabel
    }()
    
    lazy var phoneView: UIView = {
        let phoneView = UIView()
        phoneView.layer.cornerRadius = 20.pix()
        phoneView.layer.masksToBounds = true
        phoneView.layer.borderWidth = 1
        phoneView.layer.borderColor = UIColor.init(colorHex: "#050647")?.cgColor
        return phoneView
    }()
    
    lazy var codeLabel: UILabel = {
        let codeLabel = UILabel()
        codeLabel.text = "Verification Code"
        codeLabel.font = UIFont.boldSystemFont(ofSize: 18)
        codeLabel.textAlignment = .center
        codeLabel.textColor = UIColor.init(colorHex: "#000000")
        return codeLabel
    }()
    
    lazy var codeView: UIView = {
        let codeView = UIView()
        codeView.layer.cornerRadius = 20.pix()
        codeView.layer.masksToBounds = true
        codeView.layer.borderWidth = 1
        codeView.layer.borderColor = UIColor.init(colorHex: "#050647")?.cgColor
        return codeView
    }()
    
    lazy var codePinField: KAPinField = {
        let codePinField = KAPinField()
        codePinField.updateProperties { properties in
            properties.numberOfCharacters = 6
            properties.delegate = self
        }
        codePinField.updateAppearence { appearance in
            appearance.tokenColor = UIColor.clear
            appearance.backBorderWidth = 2
            appearance.backBorderColor = UIColor.init(colorHex: "#E2E0CB")!
        }
        return codePinField
    }()
    
    lazy var privacyView: UIView = {
        let privacyView = UIView()
        privacyView.layer.cornerRadius = 20.pix()
        privacyView.layer.masksToBounds = true
        privacyView.layer.borderWidth = 1
        privacyView.layer.borderColor = UIColor.init(colorHex: "#050647")?.cgColor
        return privacyView
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.isSelected = true
        clickBtn.setImage(UIImage(named: "privacyimgenor"), for: .normal)
        clickBtn.setImage(UIImage(named: "privacyimgesel"), for: .selected)
        return clickBtn
    }()
    
    lazy var privacyLabel: UILabel = {
        let privacyLabel = UILabel()
        privacyLabel.text = "By logging in, you agree to the Privacy Agreement"
        privacyLabel.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        privacyLabel.textAlignment = .left
        privacyLabel.numberOfLines = 0
        privacyLabel.textColor = UIColor.init(colorHex: "#000000")
        return privacyLabel
    }()
    
    lazy var thLabel: UILabel = {
        let thLabel = UILabel()
        thLabel.text = "+63"
        thLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        thLabel.textAlignment = .center
        thLabel.textColor = UIColor.init(colorHex: "#050647")
        return thLabel
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(colorHex: "#050647")
        return lineView
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        phoneTx.keyboardType = .numberPad
        let attrString = NSMutableAttributedString(string: "Enter mobile number", attributes: [
            .foregroundColor: UIColor.init(colorHex: "#999999") as Any,
            .font: UIFont.systemFont(ofSize: 15, weight: .regular)
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.textColor = UIColor.init(colorHex: "#000000")
        return phoneTx
    }()
    
    lazy var codeBtn: UIButton = {
        let codeBtn = UIButton(type: .custom)
        codeBtn.layer.cornerRadius = 10
        codeBtn.layer.masksToBounds = true
        codeBtn.backgroundColor = UIColor.init(colorHex: "#050647")
        codeBtn.setImage(UIImage(named: "sendcodeimage"), for: .normal)
        codeBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        codeBtn.setTitleColor(.white, for: .normal)
        codeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        codeBtn.accessibilityIdentifier = "codeIntercept"
        return codeBtn
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle("Login", for: .normal)
        loginBtn.layer.cornerRadius = 20
        loginBtn.layer.masksToBounds = true
        loginBtn.backgroundColor = UIColor.init(colorHex: "#FFC250")
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return loginBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(topImageView)
        topImageView.addSubview(welcomeImageView)
        topImageView.addSubview(logoImageView)
        topImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(437.pix())
        }
        welcomeImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(67.pix())
            make.size.equalTo(CGSize(width: 202, height: 32))
        }
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(welcomeImageView.snp.bottom).offset(61.pix())
            make.size.equalTo(CGSize(width: 62, height: 62))
        }
        
        addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(75)
            make.height.equalTo(18)
        }
        
        addSubview(phoneView)
        phoneView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneLabel.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 303.pix(), height: 70.pix()))
        }
        
        addSubview(codeLabel)
        codeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneView.snp.bottom).offset(25)
            make.height.equalTo(18)
        }
        
        addSubview(codeView)
        codeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(codeLabel.snp.bottom).offset(10)
            make.size.equalTo(CGSize(width: 303.pix(), height: 70.pix()))
        }
        
        codeView.addSubview(codePinField)
        codePinField.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(40.pix())
            make.width.equalTo(300.pix())
        }
        
        
        addSubview(privacyView)
        privacyView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.size.equalTo(CGSize(width: 303.pix(), height: 50.pix()))
        }
        
        privacyView.addSubview(clickBtn)
        clickBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 31, height: 31))
            make.left.equalToSuperview().offset(15)
        }
        
        privacyView.addSubview(privacyLabel)
        privacyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(clickBtn.snp.right).offset(10)
            make.right.equalToSuperview().offset(-30)
        }
        
        phoneView.addSubview(thLabel)
        thLabel.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(53)
        }
        
        phoneView.addSubview(lineView)
        lineView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(thLabel.snp.right)
            make.size.equalTo(CGSize(width: 1, height: 26.pix()))
        }
        
        phoneView.addSubview(phoneTx)
        phoneTx.snp.makeConstraints { make in
            make.left.equalTo(lineView.snp.right).offset(8)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-100)
        }
        
        phoneView.addSubview(codeBtn)
        codeBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 64, height: 40))
        }
        
        clickBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            clickBtn.isSelected.toggle()
            isClickPrivacy = clickBtn.isSelected
        }).disposed(by: disposeBag)
        
        addSubview(loginBtn)
        loginBtn.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.left.equalTo(codeView.snp.left)
            make.right.equalTo(codeView.snp.right)
            make.top.equalTo(codeView.snp.bottom).offset(40)
        }
        
        loginBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.block2?()
        }).disposed(by: disposeBag)
        
        
        phoneTx.rx.text
            .orEmpty
            .subscribe(onNext: { text in
                print("🚀text=====\(text)")
                PhoneNumberManager.shared.phoneNumber = text
            })
            .disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LoginView: KAPinFieldDelegate {
    
    @objc func btnClick() {
        self.block?(codeBtn)
    }
    
    func pinField(_ field: KAPinField, didFinishWith code: String) {
        print("didFinishWith : \(code)")
        if !code.isEmpty && code.count == 6 {
            codePinField.resignFirstResponder()
            self.block1?()
        }
    }
    
}

