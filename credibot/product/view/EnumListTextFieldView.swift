//
//  EnumListTextFieldView.swift
//  credibot
//
//  Created by Ava Martin on 2025/6/8.
//

import UIKit

class EnumListTextFieldView: BaseView {

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(colorHex: "#666666")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        let attrString = NSMutableAttributedString(string: "", attributes: [
            .foregroundColor: UIColor.init(colorHex: "#666666") as Any,
            .font: UIFont.systemFont(ofSize: 12, weight: .bold)
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        phoneTx.textColor = UIColor.init(colorHex: "#000000")
        return phoneTx
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(colorHex: "#000000")?.withAlphaComponent(0.7)
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(phoneTx)
        addSubview(lineView)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.pix())
            make.height.equalTo(14.pix())
            make.left.equalToSuperview().offset(25.pix())
        }
        
        phoneTx.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(24.pix())
            make.top.equalTo(nameLabel.snp.bottom).offset(14.pix())
            make.left.equalToSuperview().offset(25.pix())
        }
        
        lineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(15.pix())
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class EnumListBtnFieldView: BaseView {

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(colorHex: "#666666")
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        nameLabel.textAlignment = .left
        return nameLabel
    }()
    
    lazy var timeBtn: UIButton = {
        let timeBtn = UIButton(type: .custom)
        timeBtn.setTitleColor(.black, for: .normal)
        timeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        timeBtn.contentHorizontalAlignment = .left
        return timeBtn
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = UIColor.init(colorHex: "#000000")?.withAlphaComponent(0.7)
        return lineView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        addSubview(timeBtn)
        addSubview(lineView)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10.pix())
            make.height.equalTo(14.pix())
            make.left.equalToSuperview().offset(25.pix())
        }
        
        timeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(24.pix())
            make.top.equalTo(nameLabel.snp.bottom).offset(14.pix())
            make.left.equalToSuperview().offset(25.pix())
        }
        
        lineView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(15.pix())
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
