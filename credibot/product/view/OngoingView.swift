//
//  OngoingView.swift
//  credibot
//
//  Created by Ava Martin on 2025/5/29.
//

import UIKit
import RxRelay
import Kingfisher

class OngoingView: BaseView {
    
    var block: ((String, Int) -> Void)?
    
    var appleBlock: (() -> Void)?
    
    var model = BehaviorRelay<floatedModel?>(value: nil)
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(OngoingListViewCell.self, forCellReuseIdentifier: "OngoingListViewCell")
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
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-80.pix())
        }
        
        
        let btn = UIButton()
        btn.backgroundColor = UIColor.init(colorHex: "#050647")
        btn.layer.cornerRadius = 25.pix()
        btn.layer.masksToBounds = true
        btn.setTitle("Apply for a loan", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        addSubview(btn)
        
        btn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-15.pix())
            make.size.equalTo(CGSize(width: 345.pix(), height: 50.pix()))
        }
        btn.rx.tap.subscribe(onNext: { [weak self] in
            self?.appleBlock?()
        }).disposed(by: disposeBag)
        
        
        
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        model.asObservable()
            .compactMap { $0?.huts ?? [] }
            .bind(to: tableView.rx.items(cellIdentifier:
                                            "OngoingListViewCell",
                                         cellType:
                                            OngoingListViewCell.self)) { index, model, cell in
                cell.selectionStyle = .none
                cell.backgroundColor = .clear
                let logoUrl = model.europeans ?? ""
                let logoSourceUrl = URL(string: logoUrl)
                cell.logoImageView.kf.setImage(with: logoSourceUrl)
                
                cell.titleLabel.text = model.madetheir ?? ""
                cell.descLabel.text = model.testament ?? ""
                
                let story = model.story ?? 0
                
                cell.typeImageView.image = story == 0 ? UIImage(named: "ongongimge") : UIImage(named: "complegeimge")
                
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(hutsModel.self).subscribe(onNext: { [weak self] model in
            guard let self = self else { return }
            
            let wasthat = model.wasthat ?? ""
            let story = model.story ?? 0
            
            switch wasthat {
            case NextType.mycbdf:
                self.block?("1", story)
                break
            case NextType.mycbdg:
                self.block?("2", story)
                break
            case NextType.mycbdh:
                self.block?("3", story)
                break
            case NextType.mycbdi:
                self.block?("4", story)
                break
            case NextType.mycbdj:
                self.block?("5", story)
                break
            default:
                break
            }
            
        }).disposed(by: disposeBag)
    }
    
    @MainActor required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OngoingView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150.pix()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "listimgeonging")
        headView.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 345.pix(), height: 96.pix()))
        }
        
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor.init(colorHex: "#000000")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 12)
        titleLabel.textAlignment = .right
        headView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-65.pix())
            make.top.equalToSuperview().offset(35.pix())
            make.height.equalTo(12)
        }
        
        let progressView = UIProgressView()
        headView.addSubview(progressView)
        progressView.layer.cornerRadius = 5.pix()
        progressView.layer.masksToBounds = true
        progressView.progressTintColor = UIColor.init(colorHex: "#456DEF")
        progressView.trackTintColor = UIColor.white
        progressView.progress = 0
        progressView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(11.pix())
            make.size.equalTo(CGSize(width: 120.pix(), height: 10.pix()))
            make.right.equalToSuperview().offset(-27.pix())
        }
        
        let descLabel = UILabel()
        descLabel.textColor = UIColor.init(colorHex: "#000000")
        descLabel.font = UIFont.boldSystemFont(ofSize: 18)
        descLabel.textAlignment = .left
        descLabel.text = "Certification List"
        headView.addSubview(descLabel)
        descLabel.snp.makeConstraints { make in
            make.left.equalTo(headImageView.snp.left)
            make.bottom.equalToSuperview().offset(-15.pix())
            make.height.equalTo(18.pix())
        }
        
        self.model
            .asObservable()
            .subscribe(onNext: { model in
                guard let model = model else { return }
                let process = model.americans?.process ?? ""
                titleLabel.text = process
                let days = process.suffix(3).split(separator: "/").map { String($0) }
                if days.count == 2 {
                    let one = Int(days.first ?? "0") ?? 0
                    let two = Int(days.last ?? "0") ?? 1
                    let progerss = Float(one) / Float(two)
                    progressView.setProgress(progerss, animated: true)
                }
        }).disposed(by: disposeBag)
        
        return headView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.pix()
    }
    
}

class NextType {
    static let mycbdf = "mycbdf"
    static let mycbdg = "mycbdg"
    static let mycbdh = "mycbdh"
    static let mycbdi = "mycbdi"
    static let mycbdj = "mycbdj"
    static let mycbdk = ""
}
