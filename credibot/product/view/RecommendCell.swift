//
//  RecommendCell.swift
//  credibot
//
//  Created by Ava Martin on 2025/6/8.
//

import UIKit

class RecommendCell: BaseViewCell {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(colorHex: "#050647")
        bgView.layer.cornerRadius = 25
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "listrighticon")
        return logoImageView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.init(colorHex: "#FFFFFF")
        titleLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        titleLabel.textAlignment = .left
        return titleLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(titleLabel)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 315.pix(), height: 44.pix()))
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15.pix())
            make.size.equalTo(CGSize(width: 20.pix(), height: 20.pix()))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15.pix())
            make.height.equalTo(20.pix())
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
