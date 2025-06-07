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
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
