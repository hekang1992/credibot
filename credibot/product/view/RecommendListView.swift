//
//  RecommendListView.swift
//  credibot
//
//  Created by Ava Martin on 2025/6/8.
//

import UIKit

class RecommendListView: BaseView {
    
    lazy var leftImageView: UIImageView = {
        let leftImageView = UIImageView()
        leftImageView.layer.cornerRadius = 10.pix()
        leftImageView.layer.masksToBounds = true
        return leftImageView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textColor = UIColor.init(colorHex: "#000000")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        oneLabel.textAlignment = .left
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        twoLabel.textAlignment = .left
        twoLabel.text = "Click Upload"
        return twoLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(leftImageView)
        addSubview(oneLabel)
        addSubview(twoLabel)
        leftImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 50.pix(), height: 50.pix()))
            make.left.equalToSuperview().offset(10.pix())
        }
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalTo(leftImageView.snp.top).offset(9.pix())
            make.height.equalTo(15.pix())
            make.left.equalTo(leftImageView.snp.right).offset(10.pix())
        }
        
        twoLabel.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(6.pix())
            make.height.equalTo(15.pix())
            make.left.equalTo(leftImageView.snp.right).offset(10.pix())
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
