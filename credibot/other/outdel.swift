//
//  outdel.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/6/11.
//

import UIKit

let s2 = "o"
typealias ExitBlock = () -> Void
class LogoutView: BaseView {
    
    var block1: ExitBlock?
    var block2: ExitBlock?
    
    lazy var imgeView: UIImageView = {
        let imgeView = UIImageView()
        imgeView.image = UIImage(named: "logoutimge")
        imgeView.isUserInteractionEnabled = true
        return imgeView
    }()
    
    lazy var continueBtn: UIButton = {
        let continueBtn = UIButton(type: .custom)
        return continueBtn
    }()
    
    lazy var confirmBtn: UIButton = {
        let confirmBtn = UIButton(type: .custom)
        return confirmBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgeView)
        imgeView.addSubview(confirmBtn)
        imgeView.addSubview(continueBtn)
        imgeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25.pix())
            make.size.equalTo(CGSize(width: 345.pix(), height: 366.pix()))
        }
        confirmBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-25.pix())
            make.left.right.equalToSuperview()
            make.height.equalTo(50.pix())
        }
        continueBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(50.pix())
            make.bottom.equalTo(confirmBtn.snp.top).offset(-10.pix())
        }
        
        confirmBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block1?()
        }).disposed(by: disposeBag)
        
        continueBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block2?()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class LogDeleteView: BaseView {
    
    var block1: ExitBlock?
    var block2: ExitBlock?
    var block3: ((Bool) -> Void)?
    
    lazy var imgeView: UIImageView = {
        let imgeView = UIImageView()
        imgeView.image = UIImage(named: "delteimge")
        imgeView.isUserInteractionEnabled = true
        return imgeView
    }()
    
    lazy var continueBtn: UIButton = {
        let continueBtn = UIButton(type: .custom)
        return continueBtn
    }()
    
    lazy var confirmBtn: UIButton = {
        let confirmBtn = UIButton(type: .custom)
        return confirmBtn
    }()
    
    lazy var cyclrBtn: UIButton = {
        let cyclrBtn = UIButton(type: .custom)
        cyclrBtn.setImage(UIImage(named: "cycleimge"), for: .normal)
        cyclrBtn.setImage(UIImage(named: "btnselimge"), for: .selected)
        return cyclrBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imgeView)
        imgeView.addSubview(confirmBtn)
        imgeView.addSubview(continueBtn)
        imgeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-25.pix())
            make.size.equalTo(CGSize(width: 345.pix(), height: 400.pix()))
        }
        confirmBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-25.pix())
            make.left.right.equalToSuperview()
            make.height.equalTo(50.pix())
        }
        continueBtn.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(50.pix())
            make.bottom.equalTo(confirmBtn.snp.top).offset(-10.pix())
        }
        
        imgeView.addSubview(cyclrBtn)
        cyclrBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-145.pix())
            make.left.equalToSuperview().offset(67.5.pix())
            make.size.equalTo(CGSize(width: 14.pix(), height: 14.pix()))
        }
        
        confirmBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block1?()
        }).disposed(by: disposeBag)
        
        continueBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.block2?()
        }).disposed(by: disposeBag)
        
        cyclrBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            cyclrBtn.isSelected.toggle()
            self.block3?(cyclrBtn.isSelected)
        }).disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
