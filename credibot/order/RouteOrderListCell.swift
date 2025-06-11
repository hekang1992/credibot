//
//  RouteOrderListCell.swift
//  credibot
//
//  Created by 何康 on 2025/6/10.
//

import UIKit
import RxRelay

class RouteOrderListCell: BaseViewCell {
    
    var model = BehaviorRelay<topickModel?>(value: nil)
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .init(colorHex: "#F1F5F9")
        bgView.layer.cornerRadius = 20.pix()
        bgView.layer.masksToBounds = true
        return bgView
    }()
    
    lazy var footerImageView: UIImageView = {
        let footerImageView = UIImageView()
        footerImageView.image = UIImage(named: "orderlistcover")
        return footerImageView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.layer.cornerRadius = 5.pix()
        iconImageView.layer.masksToBounds = true
        return iconImageView
    }()

    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 12.pix(), weight: .semibold)
        return nameLabel
    }()

    lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.textColor = UIColor.white
        typeLabel.font = UIFont.systemFont(ofSize: 12.pix(), weight: .regular)
        typeLabel.textAlignment = .center
        typeLabel.layer.cornerRadius = 11.pix()
        typeLabel.layer.masksToBounds = true
        typeLabel.backgroundColor = UIColor.init(colorHex: "#FD6652")
        return typeLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.textColor = UIColor.init(colorHex: "#000000")
        descLabel.font = UIFont.systemFont(ofSize: 14.pix(), weight: .regular)
        descLabel.textAlignment = .left
        return descLabel
    }()
    
    lazy var desc1Label: UILabel = {
        let desc1Label = UILabel()
        desc1Label.textColor = UIColor.init(colorHex: "#000000")
        desc1Label.font = UIFont.systemFont(ofSize: 14.pix(), weight: .regular)
        desc1Label.textAlignment = .left
        return desc1Label
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textColor = UIColor.init(colorHex: "#000000")
        moneyLabel.font = UIFont.systemFont(ofSize: 29.pix(), weight: .bold)
        moneyLabel.textAlignment = .right
        return moneyLabel
    }()
    
    lazy var timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.textColor = UIColor.init(colorHex: "#000000")
        timeLabel.font = UIFont.systemFont(ofSize: 16.pix(), weight: .bold)
        timeLabel.textAlignment = .right
        return timeLabel
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 6.pix()
        whiteView.layer.masksToBounds = true
        return whiteView
    }()
    
    lazy var spImageView: UIImageView = {
        let spImageView = UIImageView()
        spImageView.image = UIImage(named: "speakerimge")
        return spImageView
    }()
    
    lazy var mkLabel: UILabel = {
        let mkLabel = UILabel()
        mkLabel.textColor = UIColor.init(colorHex: "#000000")
        mkLabel.font = UIFont.systemFont(ofSize: 12.pix(), weight: .regular)
        mkLabel.textAlignment = .left
        return mkLabel
    }()
    
    lazy var typeMenuView: RouteOrderTypeView = {
        let typeMenuView = RouteOrderTypeView()
        return typeMenuView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(bgView)
        bgView.addSubview(footerImageView)
        bgView.addSubview(iconImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(typeLabel)
        bgView.addSubview(descLabel)
        bgView.addSubview(desc1Label)
        bgView.addSubview(moneyLabel)
        bgView.addSubview(timeLabel)
        bgView.addSubview(whiteView)
        whiteView.addSubview(spImageView)
        whiteView.addSubview(mkLabel)
        footerImageView.addSubview(typeMenuView)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345.pix(), height: 210.pix()))
            make.bottom.equalToSuperview()
        }
        
        footerImageView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345.pix(), height: 50.pix()))
        }
        
        iconImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15.pix())
            make.left.equalToSuperview().offset(15.pix())
            make.size.equalTo(CGSize(width: 30.pix(), height: 30.pix()))
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView.snp.centerY)
            make.left.equalTo(iconImageView.snp.right).offset(6.pix())
            make.height.equalTo(14.pix())
        }
        
        typeLabel.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 83.pix(), height: 22.pix()))
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.right.equalToSuperview().offset(-15.pix())
        }
        
        descLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.pix())
            make.top.equalToSuperview().offset(63.5.pix())
            make.height.equalTo(14.pix())
        }
        
        desc1Label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.pix())
            make.top.equalTo(descLabel.snp.bottom).offset(21.pix())
            make.height.equalTo(14.pix())
        }
        
        moneyLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15.pix())
            make.height.equalTo(29.pix())
            make.centerY.equalTo(descLabel.snp.centerY)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15.pix())
            make.height.equalTo(16.pix())
            make.centerY.equalTo(desc1Label.snp.centerY)
        }
        
        whiteView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(desc1Label.snp.bottom).offset(12.pix())
            make.size.equalTo(CGSize(width: 315.pix(), height: 28.pix()))
        }
        
        spImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15.pix())
            make.size.equalTo(CGSize(width: 18.pix(), height: 18.pix()))
        }
        
        mkLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(spImageView.snp.right).offset(6.pix())
            make.height.equalTo(14.pix())
        }
        
        typeMenuView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        model.asObservable().subscribe(onNext: { [weak self] model in
            guard let self = self, let model = model else { return }
            iconImageView.kf.setImage(with: URL(string: model.mostlydressed?.shorts ?? ""))
            nameLabel.text = model.mostlydressed?.turnedquickly ?? ""
            typeLabel.text = model.mostlydressed?.curiously ?? ""
            descLabel.text = "\(model.mostlydressed?.soldgroceries ?? "")"
            desc1Label.text = "\(model.mostlydressed?.soft ?? ""):"
            
            moneyLabel.text = model.mostlydressed?.drinks ?? ""
            timeLabel.text = model.mostlydressed?.cigarettes ?? ""
            mkLabel.text = model.mostlydressed?.purposes ?? ""
            typeMenuView.titleLabel.text = model.mostlydressed?.sold ?? ""
            
            let sorts = model.mostlydressed?.sorts ?? 0
            if sorts == 1 {
                typeLabel.backgroundColor = UIColor.init(colorHex: ColorsConfig.oneColor)
            }else if sorts == 2 {
                typeLabel.backgroundColor = UIColor.init(colorHex: ColorsConfig.twoColor)
            }else if sorts == 3 {
                typeLabel.backgroundColor = UIColor.init(colorHex: ColorsConfig.threeColor)
            }else if sorts == 4 {
                typeLabel.backgroundColor = UIColor.init(colorHex: ColorsConfig.fourColor)
            }else if sorts == 5 {
                typeLabel.backgroundColor = UIColor.init(colorHex: ColorsConfig.fiveColor)
            }
            
        }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}


class ColorsConfig {
    static let oneColor = "#FD6652"
    static let twoColor = "#07B7E7"
    static let threeColor = "#FFC003"
    static let fourColor = "#09BC02"
    static let fiveColor = "#EEEEEE"
}
