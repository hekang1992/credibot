//
//  orderheadview.swift
//  credibot
//
//  Created by 何康 on 2025/5/28.
//

import UIKit

class OrderHeadView: BaseView {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var allBtn: UIButton = {
        let allBtn = UIButton(type: .custom)
        allBtn.setImage(UIImage(named: "allnor"), for: .normal)
        allBtn.setImage(UIImage(named: "allsel"), for: .selected)
        allBtn.accessibilityIdentifier = "allBtn"
        return allBtn
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setImage(UIImage(named: "applynor"), for: .normal)
        applyBtn.setImage(UIImage(named: "applysel"), for: .selected)
        applyBtn.accessibilityIdentifier = "applyBtn"
        return applyBtn
    }()
    
    lazy var repaymentBtn: UIButton = {
        let repaymentBtn = UIButton(type: .custom)
        repaymentBtn.setImage(UIImage(named: "repaynor"), for: .normal)
        repaymentBtn.setImage(UIImage(named: "repaysel"), for: .selected)
        repaymentBtn.accessibilityIdentifier = "repaymentBtn"
        return repaymentBtn
    }()
    
    lazy var finishBtn: UIButton = {
        let finishBtn = UIButton(type: .custom)
        finishBtn.setImage(UIImage(named: "finishnor"), for: .normal)
        finishBtn.setImage(UIImage(named: "finishsel"), for: .selected)
        finishBtn.accessibilityIdentifier = "finishBtn"
        return finishBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(50)
        }
        
        scrollView.addSubview(allBtn)
        allBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 77, height: 44))
            make.left.equalToSuperview().offset(15)
        }
        
        scrollView.addSubview(applyBtn)
        applyBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 144, height: 44))
            make.left.equalTo(allBtn.snp.right).offset(10)
        }
        
        scrollView.addSubview(repaymentBtn)
        repaymentBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 144, height: 44))
            make.left.equalTo(applyBtn.snp.right).offset(10)
        }
        
        scrollView.addSubview(finishBtn)
        finishBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 103, height: 44))
            make.left.equalTo(repaymentBtn.snp.right).offset(10)
            make.right.equalToSuperview().offset(-15)
        }
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
