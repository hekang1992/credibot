//
//  ChildViewCell.swift
//  credibot
//
//  Created by 何康 on 2025/6/16.
//

import UIKit
import RxRelay

class ChildViewCell: BaseViewCell {
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .init(colorHex: "#F1F5F9")
        bgView.layer.cornerRadius = 20.pix()
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var iconImagView: UIImageView = {
        let iconImagView = UIImageView()
        iconImagView.layer.cornerRadius = 6.pix()
        iconImagView.layer.masksToBounds = true
        return iconImagView
    }()
    
    lazy var productName: UILabel = {
        let productName = UILabel()
        productName.textColor = .black
        productName.textAlignment = .left
        productName.font = UIFont.systemFont(ofSize: 12.pix(), weight: .semibold)
        return productName
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = .init(colorHex: "#999999")
        descLabel.textAlignment = .center
        descLabel.backgroundColor = UIColor.init(colorHex: "#DEE6FE")
        descLabel.layer.cornerRadius = 11.pix()
        descLabel.layer.masksToBounds = true
        descLabel.font = UIFont.systemFont(ofSize: 12.pix(), weight: .regular)
        return descLabel
    }()
    
    lazy var anotherLabel: UILabel = {
        let anotherLabel = UILabel()
        anotherLabel.textColor = .black
        anotherLabel.textAlignment = .center
        anotherLabel.backgroundColor = UIColor.init(colorHex: "#FFC250")
        anotherLabel.layer.cornerRadius = 17.pix()
        anotherLabel.layer.masksToBounds = true
        anotherLabel.font = UIFont.systemFont(ofSize: 16.pix(), weight: .semibold)
        return anotherLabel
    }()
    
    lazy var pcName: UILabel = {
        let pcName = UILabel()
        pcName.textColor = .black
        pcName.textAlignment = .left
        pcName.font = UIFont.systemFont(ofSize: 14.pix(), weight: .semibold)
        return pcName
    }()
    
    lazy var pcbName: UILabel = {
        let pcbName = UILabel()
        pcbName.textColor = .black
        pcbName.textAlignment = .left
        pcbName.font = UIFont.systemFont(ofSize: 34.pix(), weight: .semibold)
        return pcbName
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(iconImagView)
        bgView.addSubview(productName)
        bgView.addSubview(descLabel)
        bgView.addSubview(anotherLabel)
        bgView.addSubview(pcName)
        bgView.addSubview(pcbName)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10.pix())
            make.size.equalTo(CGSize(width: 345.pix(), height: 121.pix()))
            make.bottom.equalToSuperview()
        }
        iconImagView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.pix())
            make.top.equalToSuperview().offset(15.pix())
            make.size.equalTo(CGSize(width: 30.pix(), height: 30.pix()))
        }
        productName.snp.makeConstraints { make in
            make.centerY.equalTo(iconImagView.snp.centerY)
            make.left.equalTo(iconImagView.snp.right).offset(5.pix())
            make.height.equalTo(14.pix())
        }
        descLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImagView.snp.centerY)
            make.left.equalTo(productName.snp.right).offset(15.pix())
            make.size.equalTo(CGSize(width: 83.pix(), height: 22.pix()))
        }
        anotherLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15.pix())
            make.size.equalTo(CGSize(width: 78.pix(), height: 34.pix()))
        }
        pcName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.pix())
            make.top.equalTo(iconImagView.snp.bottom).offset(10.pix())
            make.height.equalTo(14.pix())
        }
        pcbName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.pix())
            make.top.equalTo(pcName.snp.bottom).offset(5.pix())
            make.height.equalTo(34.pix())
        }
       
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
