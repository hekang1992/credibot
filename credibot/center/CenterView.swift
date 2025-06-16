//
//  CenterView.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/5/27.
//

import UIKit

let desc = "More"
class CenterListView: BaseView {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(colorHex: "#050647")
        bgView.layer.cornerRadius = 15
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        return logoImageView
    }()
    
    lazy var namelabel: UILabel = {
        let namelabel = UILabel()
        namelabel.textColor = UIColor.init(colorHex: "#FFFFFF")
        namelabel.textAlignment = .left
        namelabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return namelabel
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "listrighticon")
        return rightImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.height.equalTo(64)
        }
        bgView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        
        bgView.addSubview(namelabel)
        namelabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImageView.snp.right).offset(8)
            make.height.equalTo(40)
        }
        
        bgView.addSubview(rightImageView)
        rightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 22, height: 22))
        }

    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class CenterView: BaseView {

    
}
