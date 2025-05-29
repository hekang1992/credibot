//
//  HomeView.swift
//  credibot
//
//  Created by emma on 2025/5/27.
//

import UIKit

class HomeView: BaseView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
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
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textColor = UIColor.init(colorHex: "#C7F0FD")
        moneyLabel.textAlignment = .center
        moneyLabel.font = UIFont.boldSystemFont(ofSize: 64)
        return moneyLabel
    }()
    
    lazy var dayImageView: UIImageView = {
        let dayImageView = UIImageView()
        dayImageView.image = UIImage(named: "dayimge")
        return dayImageView
    }()
    
    lazy var minLabel: UILabel = {
        let minLabel = UILabel()
        minLabel.textAlignment = .center
        minLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        minLabel.textColor = UIColor.init(colorHex: "#D1EAFF")
        return minLabel
    }()
    
    lazy var maxLabel: UILabel = {
        let maxLabel = UILabel()
        maxLabel.textAlignment = .center
        maxLabel.font = UIFont.systemFont(ofSize: 18, weight: .black)
        maxLabel.textColor = UIColor.init(colorHex: "#D1EAFF")
        return maxLabel
    }()
    
    lazy var calView: UIView = {
        let calView = UIView()
        return calView
    }()
    
    lazy var clickView: UIView = {
        let clickView = UIView()
        return clickView
    }()
    
    lazy var calcureImageView: UIImageView = {
        let calcureImageView = UIImageView()
        calcureImageView.image = UIImage(named: "calcureimge")
        return calcureImageView
    }()
    
    lazy var rate1Label: UILabel = {
        let rate1Label = UILabel()
        rate1Label.textColor = UIColor.init(colorHex: "#FFFFFF")
        rate1Label.textAlignment = .left
        rate1Label.font = UIFont.systemFont(ofSize: 14)
        return rate1Label
    }()
    
    lazy var rate2Label: UILabel = {
        let rate2Label = UILabel()
        rate2Label.textColor = UIColor.init(colorHex: "#FFFFFF")
        rate2Label.textAlignment = .right
        rate2Label.font = UIFont.systemFont(ofSize: 14)
        return rate2Label
    }()
    
    lazy var detailBtn: UIButton = {
        let detailBtn = UIButton(type: .custom)
        detailBtn.setTitle("View details", for: .normal)
        detailBtn.setTitleColor(.white, for: .normal)
        detailBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        detailBtn.setImage(UIImage(named: "listrighticon"), for: .normal)
        detailBtn.semanticContentAttribute = .forceRightToLeft
        detailBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10.pix(), bottom: 0, right: 0)
        return detailBtn
    }()
    
    lazy var dataLabel: UILabel = {
        let dataLabel = UILabel()
        dataLabel.textColor = .black
        dataLabel.textAlignment = .left
        dataLabel.font = UIFont.boldSystemFont(ofSize: 18)
        dataLabel.text = "Our data"
        return dataLabel
    }()
    
    lazy var dwdLabel: UILabel = {
        let dwdLabel = UILabel()
        dwdLabel.textColor = UIColor.init(colorHex: "#999999")
        dwdLabel.textAlignment = .right
        dwdLabel.font = UIFont.boldSystemFont(ofSize: 12)
        dwdLabel.text = "Go to Apply"
        return dwdLabel
    }()

    lazy var descImageView: UIImageView = {
        let descImageView = UIImageView()
        descImageView.image = UIImage(named: "descigehome")
        descImageView.isUserInteractionEnabled = true
        return descImageView
    }()
    
    lazy var bannerView: UIView = {
        let bannerView = UIView()
        bannerView.backgroundColor = .systemBlue
        return bannerView
    }()
    
    lazy var data1Label: UILabel = {
        let data1Label = UILabel()
        data1Label.textColor = .black
        data1Label.textAlignment = .left
        data1Label.font = UIFont.boldSystemFont(ofSize: 18)
        data1Label.text = "Common Question"
        return data1Label
    }()
    
    lazy var dwd1Label: UILabel = {
        let dwd1Label = UILabel()
        dwd1Label.textColor = UIColor.init(colorHex: "#999999")
        dwd1Label.textAlignment = .right
        dwd1Label.font = UIFont.boldSystemFont(ofSize: 12)
        dwd1Label.text = "See all"
        return dwd1Label
    }()
    
    lazy var quesImageView: UIImageView = {
        let quesImageView = UIImageView()
        quesImageView.image = UIImage(named: "quesimage")
        quesImageView.isUserInteractionEnabled = true
        return quesImageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        
        scrollView.addSubview(headImageView)
        scrollView.addSubview(leftImageView)
        scrollView.addSubview(rightImageView)
        
        headImageView.addSubview(logoImageView)
        headImageView.addSubview(appNameLabel)
        
        headImageView.addSubview(descLabel)
        headImageView.addSubview(moneyLabel)
        headImageView.addSubview(dayImageView)
        
        dayImageView.addSubview(minLabel)
        dayImageView.addSubview(maxLabel)
        
        headImageView.addSubview(calView)
        headImageView.addSubview(clickView)
        
        calView.addSubview(calcureImageView)
        calView.addSubview(rate1Label)
        calView.addSubview(rate2Label)
        
        clickView.addSubview(detailBtn)
        
        scrollView.addSubview(dataLabel)
        scrollView.addSubview(dwdLabel)
        scrollView.addSubview(descImageView)
        
        
        scrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
        headImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusBarHelper.shared.topSafeAreaHeight)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345.pix(), height: 447.pix()))
        }
        
        leftImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusBarHelper.shared.topSafeAreaHeight + 14.pix())
            make.size.equalTo(CGSize(width: 40.pix(), height: 40.pix()))
            make.left.equalTo(headImageView.snp.left)
        }
        
        rightImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(StatusBarHelper.shared.topSafeAreaHeight + 14.pix())
            make.size.equalTo(CGSize(width: 40.pix(), height: 40.pix()))
            make.right.equalTo(headImageView.snp.right)
        }
        
        
        logoImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-17.pix())
            make.top.equalToSuperview().offset(100.pix())
            make.size.equalTo(CGSize(width: 32.pix(), height: 32.pix()))
        }
        
        
        appNameLabel.snp.makeConstraints { make in
            make.centerX.equalTo(logoImageView.snp.centerX)
            make.top.equalTo(logoImageView.snp.bottom).offset(1)
            make.height.equalTo(12.pix())
        }
        
        
        descLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(174.pix())
            make.height.equalTo(14.pix())
        }
        
        
        moneyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(64.pix())
            make.top.equalTo(descLabel.snp.bottom).offset(4.pix())
        }
        
        
        dayImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(moneyLabel.snp.bottom).offset(15.pix())
            make.size.equalTo(CGSize(width: 295.pix(), height: 52.pix()))
        }
        
       
        
        minLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalTo(dayImageView.snp.centerX).offset(-5.pix())
            make.height.equalTo(52.pix())
        }
        maxLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.left.equalTo(dayImageView.snp.centerX).offset(5.pix())
            make.height.equalTo(52.pix())
        }
        
        
        
        calView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(25.pix())
            make.top.equalTo(dayImageView.snp.bottom).offset(15.pix())
            make.centerX.equalToSuperview()
            make.height.equalTo(50.pix())
        }
        
        
        clickView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(25.pix())
            make.top.equalTo(calView.snp.bottom)
            make.centerX.equalToSuperview()
            make.height.equalTo(60.pix())
        }
        
        
        calcureImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
            make.size.equalTo(CGSize(width: 18.pix(), height: 18.pix()))
        }
        
        
        rate1Label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(calcureImageView.snp.right).offset(5)
            make.height.equalTo(20)
        }
        rate2Label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(20)
        }
        
        
        detailBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 255.pix(), height: 20.pix()))
        }
        
       
        
        dataLabel.snp.makeConstraints { make in
            make.left.equalTo(headImageView.snp.left)
            make.top.equalTo(headImageView.snp.bottom).offset(25.pix())
            make.height.equalTo(18.pix())
        }
        
        
        dwdLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dataLabel.snp.centerY)
            make.right.equalTo(headImageView.snp.right)
            make.height.equalTo(14)
        }
        
        
        descImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345.pix(), height: 312.pix()))
            make.top.equalTo(dataLabel.snp.bottom).offset(15.pix())
        }
        
        scrollView.addSubview(bannerView)
        bannerView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(descImageView.snp.bottom).offset(12.pix())
            make.left.equalTo(headImageView.snp.left)
            make.height.equalTo(120.pix())
        }
        
        scrollView.addSubview(data1Label)
        scrollView.addSubview(dwd1Label)
        
        data1Label.snp.makeConstraints { make in
            make.left.equalTo(headImageView.snp.left)
            make.top.equalTo(bannerView.snp.bottom).offset(25.pix())
            make.height.equalTo(18.pix())
        }
        
        dwd1Label.snp.makeConstraints { make in
            make.centerY.equalTo(data1Label.snp.centerY)
            make.right.equalTo(headImageView.snp.right)
            make.height.equalTo(14)
        }
        
        scrollView.addSubview(quesImageView)
        quesImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345.pix(), height: 204.pix()))
            make.top.equalTo(data1Label.snp.bottom).offset(15.pix())
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
