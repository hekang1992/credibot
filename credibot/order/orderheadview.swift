//
//  orderheadview.swift
//  credibot
//
//  Created by emma on 2025/5/28.
//

import UIKit

class OrderHeadView: BaseView {
    
    var block1: ((UIButton) -> Void)?
    var block2: ((UIButton) -> Void)?
    var block3: ((UIButton) -> Void)?
    var block4: ((UIButton) -> Void)?
    
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
        allBtn.adjustsImageWhenHighlighted = false
        allBtn.isSelected = true
        return allBtn
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setImage(UIImage(named: "applynor"), for: .normal)
        applyBtn.setImage(UIImage(named: "applysel"), for: .selected)
        applyBtn.accessibilityIdentifier = "applyBtn"
        applyBtn.adjustsImageWhenHighlighted = false
        return applyBtn
    }()
    
    lazy var repaymentBtn: UIButton = {
        let repaymentBtn = UIButton(type: .custom)
        repaymentBtn.setImage(UIImage(named: "repaynor"), for: .normal)
        repaymentBtn.setImage(UIImage(named: "repaysel"), for: .selected)
        repaymentBtn.accessibilityIdentifier = "repaymentBtn"
        repaymentBtn.adjustsImageWhenHighlighted = false
        return repaymentBtn
    }()
    
    lazy var finishBtn: UIButton = {
        let finishBtn = UIButton(type: .custom)
        finishBtn.setImage(UIImage(named: "finishnor"), for: .normal)
        finishBtn.setImage(UIImage(named: "finishsel"), for: .selected)
        finishBtn.accessibilityIdentifier = "finishBtn"
        finishBtn.adjustsImageWhenHighlighted = false
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
        
        allBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            reactBtns(to: allBtn)
        }).disposed(by: disposeBag)
        
        applyBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            reactBtns(to: applyBtn)
        }).disposed(by: disposeBag)
        
        repaymentBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            reactBtns(to: repaymentBtn)
        }).disposed(by: disposeBag)
        
        finishBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            reactBtns(to: finishBtn)
        }).disposed(by: disposeBag)
        
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OrderHeadView {
    
    private func reactBtns(to btn: UIButton) {
        allBtn.isSelected = false
        applyBtn.isSelected = false
        repaymentBtn.isSelected = false
        finishBtn.isSelected = false
        btn.isSelected = true
    }
    
}
