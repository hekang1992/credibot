//
//  LoginViewController.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/5/27.
//

import UIKit
import KRProgressHUD
import RxSwift

class LoginViewController: BaseViewController {
    
    var remainingSeconds: Int = 60
    
    var timer: Timer?
    
    var mix1time: String = ""
    
    var mix2time: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        let loginView = LoginView()
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        loginView.block = { [weak self] codeBtn in
            guard let self = self else { return }
            if !loginView.isClickPrivacy {
                KRProgressHUD.showMessage("Please read and confirm the privacy agreement first")
                return
            }
            let phone = loginView.phoneTx.text ?? ""
            Task {
                await self.sendCodeInfo(with: codeBtn, phone: phone)
            }
        }
        
        loginView.block1 = { [weak self] in
            guard let self = self else { return }
            login(with: loginView)
        }
        
        loginView.block2 = { [weak self] in
            guard let self = self else { return }
            login(with: loginView)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            loginView.phoneTx.becomeFirstResponder()
        }
        
        getLocation()
    }
    
    deinit {
        timer?.invalidate()
    }
    
}

extension LoginViewController {
    
    private func login(with loginView: LoginView) {
        if !loginView.isClickPrivacy {
            KRProgressHUD.showMessage("Please read and confirm the privacy agreement first")
            return
        }
        Task {
            await self.loginApiInfo(with: loginView.phoneTx.text ?? "", code: loginView.codePinField.text ?? "")
        }
    }
    
    private func sendCodeInfo(with codeBtn: UIButton, phone: String) async {
        mix1time = String(SCSignalManager.getCurrentTime())
        UserDefaults.standard.set(mix1time, forKey: "mix1time")
        UserDefaults.standard.synchronize()
        KRProgressHUD.show(withMessage: "loading...")
        let man = NetworkManager()
        let dict = ["surprising": phone,
                    "queer": "en",
                    "length": "6"]
        do {
            let result = try await man.request(
                .postData(endpoint: "/cbd/mysterious", parameters: dict),
                responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            let likesnake = result.likesnake ?? ""
            if wanted == "0" || wanted == "00" {
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] t in
                    guard let self = self else { return }
                    codeBtn.setImage(nil, for: .normal)
                    self.remainingSeconds -= 1
                    self.updateTitle(with: codeBtn)
                    if self.remainingSeconds <= 0 {
                        self.stopCountdown(with: codeBtn)
                    }
                }
            }
            KRProgressHUD.showMessage(likesnake)
        }catch {
            KRProgressHUD.dismiss()
            print(error)
        }
    }
    
    func stopCountdown(with codeBtn: UIButton) {
        timer?.invalidate()
        timer = nil
        remainingSeconds = 60
        codeBtn.isEnabled = true
        codeBtn.setTitle("", for: .normal)
        codeBtn.setImage(UIImage(named: "sendcodeimage"), for: .normal)
    }
    
    private func updateTitle(with codeBtn: UIButton) {
        codeBtn.isEnabled = false
        codeBtn.setTitle("\(remainingSeconds)s", for: .normal)
    }
    
    private func loginApiInfo(with phone: String, code: String) async {
        mix2time = String(SCSignalManager.getCurrentTime())
        UserDefaults.standard.set(mix2time, forKey: "mix2time")
        UserDefaults.standard.synchronize()
        KRProgressHUD.show(withMessage: "loading...")
        let man = NetworkManager()
        let dict = ["music": phone,
                    "queer": code,
                    "thinks": "1",
                    "piano": "0"]
        do {
            let result = try await man.request(
                .postData(endpoint: "/cbd/carhe", parameters: dict),
                responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            let likesnake = result.likesnake ?? ""
            if wanted == "0" || wanted == "00" {
                let phone = result.floated?.music ?? ""
                let token = result.floated?.noise ?? ""
                UserDefaults.standard.set(phone, forKey: "phone")
                UserDefaults.standard.set(token, forKey: "token")
                UserDefaults.standard.synchronize()
                await stepInfo(with: "", type: "1", cold: mix1time, pollys: mix2time)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    NotificationCenter.default.post(name: NSNotification.Name("changeVc"), object: nil)
                }
            }
            KRProgressHUD.showMessage(likesnake)
        }catch {
            KRProgressHUD.dismiss()
            print(error)
        }
    }
    
    private func getLocation() {
        let locationFetcher = LocationFetcher()
        locationFetcher.requestLocationOnce()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] location in
                if let self = self, let loc = location {
                    print("✅ 🚀 home ==== Rx success======：\(loc.latitude ?? 0), \(loc.longitude ?? 0), \(loc.address ?? "")")
                    Task {
                        await self.builtInfo(with: loc)
                    }
                } else {
                    print("❌ Rx error")
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func builtInfo(with model: LocationModel) async {
        let man = NetworkManager()
        let dict = ["jerry": model.proviceCode ?? "",
                    "masses": model.countryCode ?? "",
                    "stored": model.country ?? "",
                    "boards": model.longitude ?? 0.0,
                    "false": model.latitude ?? 0.0,
                    "built": model.address ?? "",
                    "holding": model.latitude ?? 0.0,
                    "oftimber": model.longitude ?? 0.0,
                    "joists": model.city ?? ""] as [String : Any]
        do {
            let _ = try await man.request(.postData(endpoint: "/cbd/themcoughed", parameters: dict), responseType: BaseModel.self)
        } catch  {
            
        }
        
    }
    
}

