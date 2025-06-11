//
//  RoutePesoViewCell.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/6/10.
//

import UIKit
import RxRelay

class RoutePesoViewCell: BaseViewCell {
    
    var model = BehaviorRelay<topickModel?>(value: nil)

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 25.pix()
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "contactimge")
        return logoImageView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textColor = UIColor.init(colorHex: "#000000")
        oneLabel.font = UIFont.systemFont(ofSize: 16, weight: .black)
        oneLabel.textAlignment = .left
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textColor = UIColor.init(colorHex: "#000000")
        twoLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        twoLabel.textAlignment = .left
        return twoLabel
    }()
    
    lazy var cornerView: UIView = {
        let cornerView = UIView()
        cornerView.backgroundColor = .white
        cornerView.layer.cornerRadius = 10.pix()
        cornerView.layer.masksToBounds = true
        cornerView.layer.borderWidth = 1.pix()
        cornerView.layer.borderColor = UIColor.init(colorHex: "#000000")?.cgColor
        return cornerView
    }()
    
    lazy var imporyLabel: UILabel = {
        let imporyLabel = UILabel()
        imporyLabel.textColor = UIColor.init(colorHex: "#999999")
        imporyLabel.textAlignment = .left
        imporyLabel.font = UIFont.systemFont(ofSize: 14.pix(), weight: .regular)
        return imporyLabel
    }()
    
    lazy var rightImageView: UIImageView = {
        let rightImageView = UIImageView()
        rightImageView.image = UIImage(named: "rightimgelis")
        return rightImageView
    }()
    
    lazy var threeLabel: UILabel = {
        let threeLabel = UILabel()
        threeLabel.textColor = UIColor.init(colorHex: "#000000")
        threeLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        threeLabel.textAlignment = .left
        return threeLabel
    }()
    
    lazy var corner1View: UIView = {
        let corner1View = UIView()
        corner1View.backgroundColor = .white
        corner1View.layer.cornerRadius = 10.pix()
        corner1View.layer.masksToBounds = true
        corner1View.layer.borderWidth = 1.pix()
        corner1View.layer.borderColor = UIColor.init(colorHex: "#000000")?.cgColor
        return corner1View
    }()
    
    lazy var impory1Label: UILabel = {
        let impory1Label = UILabel()
        impory1Label.textColor = UIColor.init(colorHex: "#999999")
        impory1Label.textAlignment = .left
        impory1Label.font = UIFont.systemFont(ofSize: 14.pix(), weight: .regular)
        return impory1Label
    }()
    
    lazy var rightImage1View: UIImageView = {
        let rightImage1View = UIImageView()
        rightImage1View.image = UIImage(named: "rightimgelis")
        return rightImage1View
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(bgView)
        contentView.addSubview(logoImageView)
        
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(15.pix())
            make.size.equalTo(CGSize(width: 345.pix(), height: 218.pix()))
            make.bottom.equalToSuperview().offset(-10.pix())
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.right.equalToSuperview().offset(-30.pix())
            make.size.equalTo(CGSize(width: 55.pix(), height: 55.pix()))
        }
        
        bgView.addSubview(oneLabel)
        bgView.addSubview(twoLabel)
        
        bgView.addSubview(cornerView)
        cornerView.addSubview(imporyLabel)
        cornerView.addSubview(rightImageView)
        
        oneLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.top.equalToSuperview().offset(25.pix())
            make.left.equalToSuperview().offset(15.pix())
        }
        
        twoLabel.snp.makeConstraints { make in
            make.height.equalTo(12)
            make.top.equalTo(oneLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15.pix())
        }
        
        cornerView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.pix())
            make.height.equalTo(40.pix())
            make.top.equalTo(twoLabel.snp.bottom).offset(10.pix())
            make.centerX.equalToSuperview()
        }
        imporyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10.pix())
            make.height.equalTo(40.pix())
            make.right.equalToSuperview().offset(-20.pix())
        }
        
        rightImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10.pix())
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 8.pix(), height: 13.pix()))
        }
        
        
        bgView.addSubview(threeLabel)
        threeLabel.snp.makeConstraints { make in
            make.height.equalTo(12)
            make.top.equalTo(cornerView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(15.pix())
        }
        
        
        bgView.addSubview(corner1View)
        corner1View.addSubview(impory1Label)
        corner1View.addSubview(rightImage1View)
        
        corner1View.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.pix())
            make.height.equalTo(40.pix())
            make.top.equalTo(threeLabel.snp.bottom).offset(10.pix())
            make.centerX.equalToSuperview()
        }
        impory1Label.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10.pix())
            make.height.equalTo(40.pix())
            make.right.equalToSuperview().offset(-20.pix())
        }
        
        rightImage1View.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10.pix())
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 8.pix(), height: 13.pix()))
        }
        
        model.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            oneLabel.text = model.imagined ?? ""
            
            let name = model.biggest ?? ""
            let phone = model.jolly ?? ""
            let listName = name + "-" + phone
            let relationText = model.relationText ?? ""
            
            twoLabel.text = "Relationship With Customers"
            
            imporyLabel.text = relationText.isEmpty ? "Please select a relationship" : relationText
            
            threeLabel.text = "Contact Information"
            
            impory1Label.text = name.isEmpty ? "Name -Phone Number" : listName
            
            imporyLabel.textColor = relationText.isEmpty ? UIColor.init(colorHex: "#999999") : .black
            
            impory1Label.textColor = name.isEmpty ? UIColor.init(colorHex: "#999999") : .black
            
        }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
