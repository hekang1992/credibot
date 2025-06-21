//
//  MessageDetailViewController.swift
//  credibot
//
//  Created by 何康 on 2025/6/21.
//

import UIKit
import KRProgressHUD

class MessageDetailViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .init(colorHex: "#F1F5F9")
        view.addSubview(backBtn)
        view.addSubview(nameLabel)
        nameLabel.text = "Common Question"
        backBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 21.5.pix(), height: 31.pix()))
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
            make.left.equalToSuperview().offset(12.pix())
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backBtn.snp.centerY)
            make.centerX.equalToSuperview()
            make.height.equalTo(20.pix())
        }
        
        backBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: disposeBag)
        
        KRProgressHUD.show(withMessage: "loading...")
        
        let imgeView = UIImageView()
        imgeView.image = UIImage(named: "meaadeil")
        view.addSubview(imgeView)
        imgeView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(10.pix())
            make.size.equalTo(CGSize(width: 345.pix(), height: 420.pix()))
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0.4...1.0)) {
            KRProgressHUD.dismiss()
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
