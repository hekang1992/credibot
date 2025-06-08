//
//  OngoingListViewCell.swift
//  credibot
//
//  Created by 何康 on 2025/5/29.
//

import UIKit

class OngoingListViewCell: BaseViewCell {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(colorHex: "#F1F5F9")
        bgView.layer.cornerRadius = 25
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        return logoImageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.init(colorHex: "#000000")
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = UIColor.init(colorHex: "#999999")
        descLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        descLabel.textAlignment = .left
        descLabel.numberOfLines = 0
        return descLabel
    }()
    
    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        return typeImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345.pix(), height: 85.pix()))
        }
        
        bgView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(25.pix())
            make.size.equalTo(CGSize(width: 55, height: 55))
        }
        
        bgView.addSubview(titleLabel)
        bgView.addSubview(descLabel)
        
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.left.equalTo(logoImageView.snp.right).offset(15)
            make.height.equalTo(20)
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(logoImageView.snp.right).offset(15)
            make.right.equalToSuperview().offset(-80)
        }
        
        bgView.addSubview(typeImageView)
        typeImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 29.pix(), height: 29.pix()))
            make.right.equalToSuperview().offset(-20.pix())
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
