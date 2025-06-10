//
//  AboutBotSelectViewCell.swift
//  credibot
//
//  Created by 何康 on 2025/6/8.
//

import UIKit

class AboutBotSelectViewCell: BaseViewCell {

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = UIColor.init(colorHex: "#000000")
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 12.pix(), weight: .regular)
        return nameLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 10.pix()
        bgView.layer.masksToBounds = true
        bgView.layer.borderWidth = 1.pix()
        bgView.layer.borderColor = UIColor.init(colorHex: "#000000")?.cgColor
        return bgView
    }()
    
    lazy var imporyLabel: UILabel = {
        let imporyLabel = UILabel()
        imporyLabel.textColor = UIColor.init(colorHex: "#999999")
        imporyLabel.textAlignment = .left
        imporyLabel.font = UIFont.systemFont(ofSize: 14.pix(), weight: .regular)
        return imporyLabel
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "rightimgelis")
        return logoImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(bgView)
        bgView.addSubview(imporyLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5.pix())
            make.left.equalToSuperview().offset(15.pix())
            make.height.equalTo(12.pix())
        }
        bgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.pix())
            make.height.equalTo(40.pix())
            make.top.equalTo(nameLabel.snp.bottom).offset(10.pix())
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-10.pix())
        }
        imporyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10.pix())
            make.height.equalTo(40.pix())
            make.right.equalToSuperview().offset(-20.pix())
        }
        
        bgView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10.pix())
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 8.pix(), height: 13.pix()))
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
