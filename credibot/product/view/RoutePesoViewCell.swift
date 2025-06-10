//
//  RoutePesoViewCell.swift
//  credibot
//
//  Created by 何康 on 2025/6/10.
//

import UIKit

class RoutePesoViewCell: BaseViewCell {

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 25.pix()
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "contactimge")
        return logoImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(bgView)
        contentView.addSubview(logoImageView)
        
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15.pix())
            make.size.equalTo(CGSize(width: 345.pix(), height: 218.pix()))
            make.bottom.equalToSuperview().offset(-10.pix())
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-30.pix())
            make.size.equalTo(CGSize(width: 55.pix(), height: 55.pix()))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
