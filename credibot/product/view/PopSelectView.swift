//
//  PopSelectView.swift
//  credibot
//
//  Created by Ava Martin on 2025/6/8.
//

import UIKit

typealias clickBlcok = (() -> Void)
class PopSelectView: BaseView {
    
    var block1: clickBlcok?
    var block2: clickBlcok?
    
    lazy var popImageView: UIImageView = {
        let popImageView = UIImageView()
        popImageView.isUserInteractionEnabled = true
        popImageView.image = UIImage(named: "selectimge")
        return popImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        return twoBtn
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(popImageView)
        popImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix(), height: 267.pix()))
        }
        
        popImageView.addSubview(oneBtn)
        popImageView.addSubview(twoBtn)
        
        oneBtn.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(130.pix())
        }
        
        twoBtn.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.top.equalTo(oneBtn.snp.bottom)
        }
        
        oneBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block1?()
        }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block2?()
        }).disposed(by: disposeBag)
        
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
