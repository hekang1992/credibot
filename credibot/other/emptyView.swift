//
//  EmptyView.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/5/29.
//

import UIKit

let personalizedUrl = commUrl + baseCommonUrl + lastSter

class EmptyView: BaseView {
    
    var block: (() -> Void)?
    
    lazy var emptyImageView: UIImageView = {
        let emptyImageView = UIImageView()
        emptyImageView.image = UIImage(named: "nodataimge")
        return emptyImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "There are currently no orders"
        nameLabel.textColor = UIColor.init(colorHex: "#999999")
        nameLabel.font = UIFont.systemFont(ofSize: 14.pix(), weight: .thin)
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitle("Apply for a loan", for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16.pix(), weight: .regular)
        applyBtn.setTitleColor(.black, for: .normal)
        applyBtn.layer.cornerRadius = 10.pix()
        applyBtn.backgroundColor = UIColor.init(colorHex: "#FFC250")
        return applyBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(emptyImageView)
        addSubview(nameLabel)
        addSubview(applyBtn)
        
        emptyImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40.pix())
            make.size.equalTo(CGSize(width: 227.pix(), height: 168.pix()))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(2)
            make.height.equalTo(14)
            make.centerX.equalToSuperview()
        }
        
        applyBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 170.pix(), height: 36.pix()))
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(8.pix())
        }
        
        applyBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block?()
        }).disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
