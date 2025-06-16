//
//  HomeChildView.swift
//  credibot
//
//  Created by 何康 on 2025/6/14.
//

import UIKit
import RxRelay

class HomeChildView: BaseView {
    
    var pageBlock: ((String) -> Void)?
    
    var productBlock: ((String) -> Void)?
    
    var floatModel = BehaviorRelay<floatedModel?>(value: nil)
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "chimdimge")
        headImageView.isUserInteractionEnabled = true
        return headImageView
    }()
    
    lazy var speakerImageView: UIImageView = {
        let speakerImageView = UIImageView()
        speakerImageView.image = UIImage(named: "speckimge")
        return speakerImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = desc + " " + pro
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 18.pix(), weight: .bold)
        return nameLabel
    }()
    
    lazy var descLabel: UILabel = {
        let descLabel = UILabel()
        descLabel.text = "Go to Apply"
        descLabel.textColor = .init(colorHex: "#999999")
        descLabel.textAlignment = .right
        descLabel.font = UIFont.systemFont(ofSize: 12.pix(), weight: .regular)
        return descLabel
    }()
    
    lazy var desc1Label: UILabel = {
        let desc1Label = UILabel()
        desc1Label.textColor = .white
        desc1Label.textAlignment = .left
        desc1Label.font = UIFont.systemFont(ofSize: 14.pix(), weight: .semibold)
        return desc1Label
    }()
    
    lazy var moneyLabel: UILabel = {
        let moneyLabel = UILabel()
        moneyLabel.textColor = .white
        moneyLabel.textAlignment = .left
        moneyLabel.font = UIFont.systemFont(ofSize: 44.pix(), weight: .semibold)
        return moneyLabel
    }()
    
    lazy var rateLabel: UILabel = {
        let rateLabel = UILabel()
        rateLabel.textColor = .white
        rateLabel.textAlignment = .center
        rateLabel.backgroundColor = .clear
        rateLabel.layer.cornerRadius = 11.pix()
        rateLabel.layer.masksToBounds = true
        rateLabel.layer.borderWidth = 0.5.pix()
        rateLabel.layer.borderColor = UIColor.white.cgColor
        rateLabel.font = UIFont.systemFont(ofSize: 12.pix(), weight: .regular)
        return rateLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(ChildViewCell.self, forCellReuseIdentifier: "ChildViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    lazy var mcView: RouteOrderTypeView = {
        let mcView = RouteOrderTypeView()
        return mcView
    }()
    
    lazy var marqueeView: MarqueeView = {
        let marqueeView = MarqueeView()
        return marqueeView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.left.right.bottom.equalToSuperview()
        }
        
        floatModel.map({ $0?.lost?.skinny ?? [] }).bind(to: tableView.rx.items(cellIdentifier: "ChildViewCell", cellType: ChildViewCell.self)) { index, model, cell in
            cell.model.accept(model)
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
        }.disposed(by: disposeBag)
        
        
        addSubview(marqueeView)
        marqueeView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 200, height: 30))
        }
        
        tableView.rx.modelSelected(skinnyModel.self).subscribe(onNext: { [weak self] model in
            guard let self = self else { return }
            let grabbed = model.grabbed ?? 0
            self.productBlock?(String(grabbed))
        }).disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeChildView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 240.pix()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        headView.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 345.pix(), height: 195.pix()))
        }
        
        headImageView.addSubview(speakerImageView)
        speakerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23.5.pix())
            make.left.equalToSuperview().offset(43.pix())
            make.size.equalTo(CGSize(width: 18.pix(), height: 18.pix()))
        }
        
        headView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.pix())
            make.bottom.equalToSuperview().offset(-4.pix())
            make.height.equalTo(20.pix())
        }
        
        headView.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-15.pix())
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.height.equalTo(14.pix())
        }
        
        headImageView.addSubview(marqueeView)
        marqueeView.snp.makeConstraints { make in
            make.centerY.equalTo(speakerImageView.snp.centerY)
            make.left.equalTo(speakerImageView.snp.right).offset(6.pix())
            make.height.equalTo(20.pix())
            make.right.equalToSuperview().offset(-60.pix())
        }
        
        marqueeView.configure(with: self.floatModel.value?.plates?.skinny ?? [])
        
        marqueeView.onItemTapped = { [weak self] item in
            self?.pageBlock?(item.admiration ?? "")
        }
        
        
        headImageView.addSubview(desc1Label)
        desc1Label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30.pix())
            make.top.equalToSuperview().offset(65.pix())
            make.height.equalTo(14.pix())
        }
        
        
        headImageView.addSubview(moneyLabel)
        moneyLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(30.pix())
            make.top.equalTo(desc1Label.snp.bottom).offset(15.pix())
            make.height.equalTo(44.pix())
        }
        
        let iconImagView = UIImageView()
        iconImagView.layer.cornerRadius = 4.pix()
        iconImagView.layer.masksToBounds = true
        
        let productName = UILabel()
        productName.textColor = .black
        productName.textAlignment = .center
        productName.font = UIFont.systemFont(ofSize: 12.pix(), weight: .semibold)
        
        headImageView.addSubview(productName)
        productName.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-31.pix())
            make.height.equalTo(23.pix())
            make.bottom.equalTo(moneyLabel.snp.bottom).offset(-6.pix())
        }
        
        headImageView.addSubview(iconImagView)
        iconImagView.snp.makeConstraints { make in
            make.right.equalTo(productName.snp.left).offset(-4.pix())
            make.centerY.equalTo(productName.snp.centerY)
            make.size.equalTo(CGSize(width: 23.pix(), height: 23.pix()))
        }
        
        headImageView.addSubview(rateLabel)
        rateLabel.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 83.pix(), height: 25.pix()))
            make.centerY.equalTo(desc1Label.snp.centerY)
            make.right.equalToSuperview().offset(-30.pix())
        }
        
        
        headImageView.addSubview(mcView)
        mcView.snp.makeConstraints { make in
            make.height.equalTo(50.pix())
            make.bottom.equalToSuperview()
            make.width.equalTo(345.pix())
            make.top.equalTo(moneyLabel.snp.bottom).offset(7.pix())
        }
        
        if let model = self.floatModel.value?.lost?.skinny?[0] {
            desc1Label.text = model.orbreaking ?? ""
            moneyLabel.text = "₱\(model.clapping ?? "")"
            productName.text = model.turnedquickly ?? ""
            iconImagView.kf.setImage(with: URL(string: model.shorts ?? ""), placeholder: UIImage(named: "logoplaceh"))
            rateLabel.text = model.impossible ?? ""
            mcView.titleLabel.text = model.sliding ?? ""
        }
        
        headImageView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            if let model = self.floatModel.value?.lost?.skinny?[0] {
                self.productBlock?(String(model.grabbed ?? 0))
            }
        }).disposed(by: disposeBag)
        
        return headView
    }
    
    
}
