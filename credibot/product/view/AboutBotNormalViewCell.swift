//
//  AboutBotNormalViewCell.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/6/8.
//

import UIKit
import RxRelay

class AboutBotNormalViewCell: BaseViewCell {
    
    var model = BehaviorRelay<traysModel?>(value: nil)

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(colorHex: "#000000")
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 12.pix(), weight: .regular)
        return nameLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 10.pix()
        bgView.layer.masksToBounds = true
        bgView.layer.borderWidth = 1.pix()
        bgView.layer.borderColor = UIColor.init(colorHex: "#000000")?.cgColor
        return bgView
    }()
    
    lazy var phoneTx: UITextField = {
        let phoneTx = UITextField()
        let attrString = NSMutableAttributedString(string: "", attributes: [
            .foregroundColor: UIColor.init(colorHex: "#999999") as Any,
            .font: UIFont.systemFont(ofSize: 12, weight: .bold)
        ])
        phoneTx.attributedPlaceholder = attrString
        phoneTx.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        phoneTx.textColor = UIColor.init(colorHex: "#000000")
        return phoneTx
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgView)
        bgView.addSubview(phoneTx)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5.pix())
            make.left.equalToSuperview().offset(15.pix())
            make.height.equalTo(12.pix())
        }
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.pix())
            make.height.equalTo(40.pix())
            make.top.equalTo(nameLabel.snp.bottom).offset(10.pix())
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10.pix())
        }
        phoneTx.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10.pix())
            make.height.equalTo(40.pix())
            make.right.equalToSuperview().offset(-20.pix())
        }
        
        
        model.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            
            let type = model.wares ?? ""
            let name = model.madetheir ?? ""
            let placeName = model.testament ?? ""
            let passed = model.passed ?? 0
            let noisy = model.noisy ?? ""
            
            
            nameLabel.text = name
            phoneTx.placeholder = placeName
            phoneTx.text = ""
            
            if passed == 1 {
                phoneTx.keyboardType = .numberPad
            }else {
                phoneTx.keyboardType = .default
            }
            
            phoneTx.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
            if noisy.isEmpty {
                phoneTx.placeholder = placeName
            }else {
                phoneTx.text = noisy
                print("noisy=======\(noisy)")
            }
            model.noisy = noisy.isEmpty ? "" : noisy
            
        }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if let listModel = self.model.value {
            listModel.noisy = textField.text
        }
    }
    
}
