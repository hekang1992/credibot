//
//  RecommendStepView.swift
//  credibot
//
//  Created by Ava Martin on 2025/6/8.
//

import UIKit

class RecommendStepView: BaseView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(colorHex: "#050647")
        bgView.layer.cornerRadius = 20.pix()
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "prefenceimge")
        return logoImageView
    }()
    
    lazy var errorImageView: UIImageView = {
        let errorImageView = UIImageView()
        errorImageView.image = UIImage(named: "errorimge")
        return errorImageView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setTitle("Continue certification", for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.pix(), weight: .bold)
        nextBtn.backgroundColor = UIColor.init(colorHex: "#050647")
        nextBtn.layer.cornerRadius = 25.pix()
        nextBtn.layer.masksToBounds = true
        return nextBtn
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textColor = UIColor.init(colorHex: "#FFFFFF")
        oneLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        oneLabel.textAlignment = .center
        oneLabel.text = "Please authenticate"
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textColor = UIColor.init(colorHex: "#CCDAF5")
        twoLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        twoLabel.textAlignment = .center
        twoLabel.text = "Complete certification and obtain quota"
        return twoLabel
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = UIColor.white
        whiteView.layer.cornerRadius = 20.pix()
        whiteView.layer.masksToBounds = true
        return whiteView
    }()
    
    lazy var leftView: RecommendListView = {
        let leftView = RecommendListView()
        leftView.oneLabel.text = ""
        leftView.twoLabel.textColor = UIColor.init(colorHex: "#456DEF")
        leftView.leftImageView.image = UIImage(named: "kefimge")
        return leftView
    }()
    
    lazy var rightView: RecommendListView = {
        let rightView = RecommendListView()
        rightView.oneLabel.text = "Face"
        rightView.twoLabel.textColor = UIColor.init(colorHex: "#E438CF")
        rightView.leftImageView.image = UIImage(named: "rightimge")
        return rightView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.addSubview(bgView)
        scrollView.addSubview(logoImageView)
        scrollView.addSubview(errorImageView)
        scrollView.addSubview(nextBtn)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345.pix(), height: 258.pix()))
            make.top.equalToSuperview().offset(90.pix())
        }
        logoImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 149.pix(), height: 149.pix()))
            make.top.equalToSuperview().offset(10.pix())
        }
        errorImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(bgView.snp.bottom).offset(25.pix())
            make.size.equalTo(CGSize(width: 345.pix(), height: 243.pix()))
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(errorImageView.snp.bottom).offset(18.pix())
            make.size.equalTo(CGSize(width: 345.pix(), height: 50.pix()))
            make.bottom.equalToSuperview().offset(-50.pix())
        }
        
        bgView.addSubview(oneLabel)
        bgView.addSubview(twoLabel)
        
        oneLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(85.pix())
            make.height.equalTo(20)
        }
        twoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(oneLabel.snp.bottom).offset(1.pix())
            make.height.equalTo(12)
        }
        
        bgView.addSubview(whiteView)
        whiteView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(twoLabel.snp.bottom).offset(25)
            make.size.equalTo(CGSize(width: 315.pix(), height: 100.pix()))
        }
        
        whiteView.addSubview(leftView)
        whiteView.addSubview(rightView)
        
        leftView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(157.5.pix())
        }
        rightView.snp.makeConstraints { make in
            make.right.top.bottom.equalToSuperview()
            make.width.equalTo(157.5.pix())
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
