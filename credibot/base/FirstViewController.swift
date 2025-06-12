//
//  FirstViewController.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/5/27.
//

import UIKit
import FBSDKCoreKit
import AppTrackingTransparency
import RxSwift

class FirstViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let bgImageView = UIImageView(frame: self.view.bounds)
        bgImageView.image = UIImage(named: "launch")
        bgImageView.contentMode = .scaleAspectFill
        view.addSubview(bgImageView)
        
        
        getInitInfo()
        
    }
    
}

extension FirstViewController {
    
    private func getInitInfo() {
        
        NetInfoManager.shared.observeNetworkStatus { status in
            if status != .none {
                self.getAppInit()
            }
        }
        
    }
    
    private func getAppInit() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if #available(iOS 14.0, *) {
                ATTrackingManager.requestTrackingAuthorization { status in
                    switch status {
                    case .restricted:
                        break
                    case .authorized, .notDetermined, .denied:
                        Task {
                            await self.getAppAdvInfo()
                        }
                        break
                    @unknown default:
                        break
                    }
                }
            }
        }
        
    }
    
    private func getAppAdvInfo() async {
        let man = NetworkManager()
        let dict = ["flimsy": "1",
                    "noback": DeviceIdentifier.getIDFV(),
                    "temples": DeviceIdentifier.getIDFA()]
        do {
            let result = try await man.request(.postData(endpoint: "/cbd/enormous", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            if wanted == "0" || wanted == "00" {
                if let model = result.floated?.group {
                    faceBookModel(from: model)
                }
            }
            NotificationCenter.default.post(name: NSNotification.Name("changeVc"), object: nil)
        } catch  {
            print("🚀===============")
            NotificationCenter.default.post(name: NSNotification.Name("changeVc"), object: nil)
        }
    }
    
    private func faceBookModel(from model: groupModel) {
        Settings.shared.appID = model.hanky ?? ""
        Settings.shared.clientToken = model.realistic ?? ""
        Settings.shared.displayName = model.offered ?? ""
        Settings.shared.appURLSchemeSuffix = model.makethe ?? ""
        ApplicationDelegate.shared.application(UIApplication.shared, didFinishLaunchingWithOptions: nil)
    }
    
}
