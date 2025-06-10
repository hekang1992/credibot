//
//  AboutBotView.swift
//  credibot
//
//  Created by 何康 on 2025/6/8.
//

import UIKit
import RxRelay

class AboutBotView: BaseView {
    
    var listArray = BehaviorRelay<[traysModel]?>(value: nil)
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.white
        bgView.layer.cornerRadius = 25.pix()
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = .white
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "drawerimge")
        return logoImageView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setTitle("Next step", for: .normal)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14.pix(), weight: .bold)
        nextBtn.backgroundColor = UIColor.init(colorHex: "#050647")
        nextBtn.layer.cornerRadius = 25.pix()
        nextBtn.layer.masksToBounds = true
        return nextBtn
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(AboutBotNormalViewCell.self, forCellReuseIdentifier: "AboutBotNormalViewCell")
        tableView.register(AboutBotSelectViewCell.self, forCellReuseIdentifier: "AboutBotSelectViewCell")
        tableView.estimatedRowHeight = 80
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        addSubview(logoImageView)
        addSubview(nextBtn)
        bgView.addSubview(tableView)
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(15.pix())
            make.top.equalToSuperview().offset(15.pix())
            make.bottom.equalToSuperview().offset(-85.pix())
        }
        logoImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-30.pix())
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 55.pix(), height: 55.pix()))
        }
        nextBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20.pix())
            make.size.equalTo(CGSize(width: 345.pix(), height: 50.pix()))
        }
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20.pix())
            make.left.right.bottom.equalToSuperview()
        }
        
        listArray.compactMap { $0 }.bind(to: tableView.rx.items) { tableView, index, model in
            let type = model.wares ?? ""
            let name = model.madetheir ?? ""
            let placeName = model.testament ?? ""
            if type == "mycbdk" || type == "mycbdm" {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "AboutBotSelectViewCell", for: IndexPath(row: index, section: 0)) as? AboutBotSelectViewCell {
                    cell.nameLabel.text = name
                    cell.imporyLabel.text = placeName
                    cell.selectionStyle = .none
                    cell.backgroundColor = .clear
                    return cell
                }
            }else {
                if let cell = tableView.dequeueReusableCell(withIdentifier: "AboutBotNormalViewCell", for: IndexPath(row: index, section: 0)) as? AboutBotNormalViewCell {
                    cell.nameLabel.text = name
                    cell.phoneTx.placeholder = placeName
                    cell.selectionStyle = .none
                    cell.backgroundColor = .clear
                    return cell
                }
            }
            return UITableViewCell()
        }.disposed(by: disposeBag)
        
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
