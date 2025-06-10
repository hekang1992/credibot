//
//  PublicCardViewController.swift
//  credibot
//
//  Created by Ava Martin on 2025/6/8.
//

import UIKit

class PublicCardViewController: BaseViewController {
    
    var productID: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backBtn)
        view.addSubview(nameLabel)
        nameLabel.text = "Work Information"
        backBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 18.pix(), height: 26.pix()))
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(5)
            make.left.equalToSuperview().offset(12.pix())
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backBtn.snp.centerY)
            make.centerX.equalToSuperview()
            make.height.equalTo(20.pix())
        }
        
        backBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
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
