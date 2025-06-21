//
//  EnumListView.swift
//  credibot
//
//  Created by Ava Martin on 2025/6/8.
//

import UIKit

class EnumListView: BaseView {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 25.pix()
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "tagimge")
        return logoImageView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.text = "Identity information"
        oneLabel.textColor = UIColor.init(colorHex: "#000000")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: .black)
        oneLabel.textAlignment = .left
        return oneLabel
    }()
    
    
    lazy var oneListView: EnumListTextFieldView = {
        let oneListView = EnumListTextFieldView()
        oneListView.nameLabel.text = "Full Name"
        oneListView.phoneTx.placeholder = "Full Name"
        return oneListView
    }()
    
    lazy var twoListView: EnumListTextFieldView = {
        let twoListView = EnumListTextFieldView()
        twoListView.nameLabel.text = "ID NO."
        twoListView.phoneTx.placeholder = "ID NO."
        return twoListView
    }()
    
    lazy var threeListView: EnumListBtnFieldView = {
        let threeListView = EnumListBtnFieldView()
        threeListView.nameLabel.text = "Date of Birth"
        return threeListView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setTitle("Confirm", for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.pix(), weight: .bold)
        nextBtn.backgroundColor = UIColor.init(colorHex: "#050647")
        nextBtn.layer.cornerRadius = 25.pix()
        nextBtn.layer.masksToBounds = true
        return nextBtn
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        cancelBtn.setImage(UIImage(named: "qrimgecha"), for: .normal)
        cancelBtn.backgroundColor = .lightGray
        cancelBtn.layer.cornerRadius = 17.pix()
        cancelBtn.layer.masksToBounds = true
        return cancelBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(393.pix())
        }
        bgView.addSubview(logoImageView)
        bgView.addSubview(oneLabel)
        
        logoImageView.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 30.pix(), height: 24.pix()))
            make.top.equalToSuperview().offset(15.pix())
            make.left.equalToSuperview().offset(25.pix())
        }
        oneLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView.snp.centerY)
            make.left.equalTo(logoImageView.snp.right).offset(10.pix())
            make.height.equalTo(15.pix())
        }
        
        bgView.addSubview(oneListView)
        bgView.addSubview(twoListView)
        bgView.addSubview(threeListView)
        
        oneListView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(10.pix())
            make.height.equalTo(70.pix())
        }
        twoListView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(oneListView.snp.bottom).offset(10.pix())
            make.height.equalTo(70.pix())
        }
        threeListView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.centerX.equalToSuperview()
            make.top.equalTo(twoListView.snp.bottom).offset(10.pix())
            make.height.equalTo(70.pix())
        }
        
        bgView.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.pix())
            make.centerX.equalToSuperview()
            make.top.equalTo(threeListView.snp.bottom).offset(20.pix())
            make.height.equalTo(50.pix())
        }
        
        bgView.addSubview(cancelBtn)
        cancelBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15.pix())
            make.centerY.equalTo(oneLabel.snp.centerY)
            make.size.equalTo(CGSize(width: 34.pix(), height: 34.pix()))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
