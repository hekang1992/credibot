//
//  EmptyView.swift
//  credibot
//
//  Created by emma on 2025/5/29.
//

import UIKit

class EmptyView: BaseView {
    
    lazy var emptyImageView: UIImageView = {
        let emptyImageView = UIImageView()
        emptyImageView.image = UIImage(named: "nodataimge")
        return emptyImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "There are currently no orders"
        nameLabel.textColor = UIColor.init(colorHex: "#999999")
        nameLabel.font = UIFont.systemFont(ofSize: 10, weight: .thin)
        nameLabel.textAlignment = .center
        return nameLabel
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitle("Apply for a loan", for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        applyBtn.setTitleColor(.black, for: .normal)
        applyBtn.layer.cornerRadius = 5
        applyBtn.backgroundColor = UIColor.init(colorHex: "#FFC250")
        return applyBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(emptyImageView)
        addSubview(nameLabel)
        addSubview(applyBtn)
        
        emptyImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 114, height: 84))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(emptyImageView.snp.bottom).offset(2)
            make.height.equalTo(10)
            make.centerX.equalToSuperview()
        }
        
        applyBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 84, height: 18))
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
