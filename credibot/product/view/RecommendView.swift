//
//  RecommendView.swift
//  credibot
//
//  Created by Ava Martin on 2025/6/8.
//

import UIKit

class RecommendView: BaseView {

    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "robetimge")
        return iconImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 20.pix()
        bgView.backgroundColor = UIColor.init(colorHex: "#FFC250")
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Select an id to verify your identity"
        titleLabel.font = UIFont.systemFont(ofSize: 14.pix(), weight: .bold)
        titleLabel.textAlignment = .left
        titleLabel.textColor = .black
        return titleLabel
    }()
    
    lazy var grayView: UIView = {
        let grayView = UIView()
        grayView.backgroundColor = UIColor.init(colorHex: "#F1F5F9")
        grayView.layer.cornerRadius = 25.pix()
        grayView.layer.masksToBounds = true
        return grayView
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = "Recommended lD Type"
        descLabel.font = UIFont.systemFont(ofSize: 14.pix(), weight: .bold)
        descLabel.textAlignment = .left
        descLabel.textColor = .black
        return descLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(RecommendCell.self, forCellReuseIdentifier: "RecommendCell")
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        addSubview(iconImageView)
        
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(22.pix())
            make.size.equalTo(CGSize(width: 328.pix(), height: 50.pix()))
        }
        
        iconImageView.snp.makeConstraints { make in
            make.bottom.equalTo(bgView.snp.bottom).offset(-5.pix())
            make.left.equalToSuperview().offset(15.pix())
            make.size.equalTo(CGSize(width: 62.pix(), height: 78.pix()))
        }
        
        bgView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-33.5.pix())
            make.height.equalTo(20)
        }
        
        addSubview(grayView)
        grayView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgView.snp.bottom).offset(15.pix())
            make.size.equalTo(CGSize(width: 345.pix(), height: 600.pix()))
        }
        
        grayView.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15.pix())
            make.left.equalToSuperview().offset(15.pix())
            make.height.equalTo(16.pix())
        }
        
        grayView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(descLabel.snp.bottom).offset(10.pix())
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
