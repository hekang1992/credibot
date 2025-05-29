//
//  HomeView.swift
//  credibot
//
//  Created by 何康 on 2025/5/27.
//

import UIKit

class HomeView: BaseView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.isUserInteractionEnabled = true
        headImageView.image = UIImage(named: "homeheadImage")
        return headImageView
    }()
    
    lazy var leftImageView: UIImageView = {
        let leftImageView = UIImageView()
        leftImageView.image = UIImage(named: "leftimge")
        return leftImageView
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "rightimge")
        return rightImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "headlogo")
        return logoImageView
    }()
    
    lazy var appNameLabel: UILabel = {
        let appNameLabel = UILabel()
        appNameLabel.font = UIFont.systemFont(ofSize: 12)
        appNameLabel.textAlignment = .center
        appNameLabel.textColor = UIColor.init(colorHex: "#CCDAF5")
        return appNameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = UIColor.init(colorHex: "#CCDAF5")
        descLabel.textAlignment = .center
        descLabel.font = UIFont.systemFont(ofSize: 14, weight: .thin)
        return descLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(headImageView)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        headImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345.pix(), height: 447.pix()))
        }
        scrollView.addSubview(leftImageView)
        scrollView.addSubview(rightImageView)
        
        leftImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(14)
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.left.equalTo(headImageView.snp.left)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(14)
            make.size.equalTo(CGSize(width: 40, height: 40))
            make.right.equalTo(headImageView.snp.right)
        }
        
        headImageView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-17.pix())
            make.top.equalToSuperview().offset(100.pix())
            make.size.equalTo(CGSize(width: 32, height: 32))
        }
        
        headImageView.addSubview(appNameLabel)
        appNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(logoImageView.snp.centerX)
            make.top.equalTo(logoImageView.snp.bottom).offset(1)
            make.height.equalTo(12)
        }
        
        headImageView.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(174.pix())
            make.height.equalTo(14)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
