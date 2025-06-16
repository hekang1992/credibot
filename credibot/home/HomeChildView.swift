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
        
        let speakerImageView = UIImageView()
        speakerImageView.image = UIImage(named: "speckimge")
        headImageView.addSubview(speakerImageView)
        speakerImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(23.5.pix())
            make.left.equalToSuperview().offset(43.pix())
            make.size.equalTo(CGSize(width: 18.pix(), height: 18.pix()))
        }
        
        let nameLabel = UILabel()
        nameLabel.text = desc + " " + pro
        nameLabel.textColor = .black
        nameLabel.textAlignment = .left
        nameLabel.font = UIFont.systemFont(ofSize: 18.pix(), weight: .bold)
        
        headView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15.pix())
            make.bottom.equalToSuperview().offset(-4.pix())
            make.height.equalTo(20.pix())
        }
        
        let descLabel = UILabel()
        descLabel.text = "Go to Apply"
        descLabel.textColor = .init(colorHex: "#999999")
        descLabel.textAlignment = .right
        descLabel.font = UIFont.systemFont(ofSize: 12.pix(), weight: .regular)
        
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
        
        return headView
    }
    
    
}
