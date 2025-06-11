//
//  RouteOrderTypeView.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/6/11.
//

import UIKit

class RouteOrderTypeView: BaseView {
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.init(colorHex: "#D1EAFF")
        titleLabel.font = UIFont.systemFont(ofSize: 18.pix(), weight: .bold)
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "listrighticon")
        return logoImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(logoImageView)
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(20.pix())
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview().offset(-10.pix())
        }
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(titleLabel.snp.right).offset(5.pix())
            make.size.equalTo(CGSize(width: 19.pix(), height: 19.pix()))
        }
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
