//
//  RecommendStepViewController.swift
//  credibot
//
//  Created by Ava Martin on 2025/6/8.
//

import UIKit
import TYAlertController
import KRProgressHUD

class RecommendStepViewController: BaseViewController {
    
    private var imageBool: Bool = false
    private var faceBool: Bool = false
    
    var type: String = ""
    
    var productID: String = ""
    
    var minImage: String = ""
    var minCamera: String = ""
    
    lazy var bgView: RecommendStepView = {
        let bgView = RecommendStepView()
        return bgView
    }()
    
    private let cameraHelper = CameraHelper()
    
    private let photoHelper = PhotoLibraryHelper()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        minImage = String(SCSignalManager.getCurrentTime())
        view.addSubview(backBtn)
        view.addSubview(nameLabel)
        nameLabel.text = "Identity information"
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
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(backBtn.snp.bottom).offset(15.pix())
        }
        
        bgView.leftView.oneLabel.text = type
        
        
        bgView.leftView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            if imageBool {
                KRProgressHUD.showMessage("Authentication completed.")
                return
            }else {
                let popView = PopSelectView(frame: CGRectMake(0, 0, screen_width, screen_height))
                let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)!
                self.present(alertVc, animated: true)
                
                popView.block1 = { [weak self] in
                    guard let self = self else { return }
                    self.dismiss(animated: true) {
                        self.cameraHelper.getCameraImage(from: self, type: "0") { image in
                            Task {
                                await self.notGoImageVc(with: image, child: "11")
                            }
                        }
                    }
                }
                
                popView.block2 = { [weak self] in
                    guard let self = self else { return }
                    self.dismiss(animated: true) {
                        self.photoHelper.getPhotoLibraryImage(from: self) { image in
                            Task {
                                await self.notGoImageVc(with: image, child: "11")
                            }
                        }
                    }
                }
            }
        }).disposed(by: disposeBag)
        
        bgView.rightView.rx.tapGesture().when(.recognized).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            minCamera = String(SCSignalManager.getCurrentTime())
            if !imageBool {
                KRProgressHUD.showMessage("Please complete the previous step first.")
                return
            }else if imageBool && !faceBool {
                self.cameraHelper.getCameraImage(from: self, type: "1") { image in
                    Task {
                        await self.notGoImageVc(with: image, child: "10")
                    }
                }
            }else if imageBool && faceBool {
                KRProgressHUD.showMessage("Authentication completed.")
                return
            }
        }).disposed(by: disposeBag)
        
        bgView.nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if imageBool == false {
                let popView = PopSelectView(frame: CGRectMake(0, 0, screen_width, screen_height))
                let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)!
                self.present(alertVc, animated: true)
                
                popView.block1 = { [weak self] in
                    guard let self = self else { return }
                    self.dismiss(animated: true) {
                        self.cameraHelper.getCameraImage(from: self, type: "0") { image in
                            Task {
                                await self.notGoImageVc(with: image, child: "11")
                            }
                        }
                    }
                }
                
                popView.block2 = { [weak self] in
                    guard let self = self else { return }
                    self.dismiss(animated: true) {
                        self.photoHelper.getPhotoLibraryImage(from: self) { image in
                            Task {
                                await self.notGoImageVc(with: image, child: "11")
                            }
                        }
                    }
                }
            }else if imageBool && !faceBool {
                minCamera = String(SCSignalManager.getCurrentTime())
                self.cameraHelper.getCameraImage(from: self, type: "1") { image in
                    Task {
                        await self.notGoImageVc(with: image, child: "10")
                    }
                }
            }else if imageBool && faceBool {
                Task {
                    await self.getProdectDetailInfoToVc(to: self.productID)
                }
            }
        }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            Task {
                await self.getAuthInfo()
            }
        }
    }
    
}

extension RecommendStepViewController {
    
    private func notGoImageVc(with image: UIImage, child: String) async {
        KRProgressHUD.show(withMessage: "loading...")
        let man = NetworkManager()
        let imageData = image.jpegData(compressionQuality: 0.2)
        let dict = ["presumably": "1",
                    "test": productID,
                    "child": child,
                    "tobuy": type,
                    "objectssuch": "",
                    "gimcrack": "1"]
        do {
            let result = try await man.request(.uploadImage(endpoint: "/cbd/managersaw", imageData: imageData, parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            let likesnake = result.likesnake ?? ""
            if wanted == "0" || wanted == "00" {
                if let model = result.floated {
                    if child == "11" {
                        sageNotMeInfo(with: model)
                    }else if child == "10" {
                        Task {
                            await getAuthInfo()
                            await stepInfo(with: productID, type: "4", cold: minCamera, pollys: String(SCSignalManager.getCurrentTime()))
                        }
                    }
                }
            }
            KRProgressHUD.showMessage(likesnake)
        }catch {
            KRProgressHUD.dismiss()
        }
    }
    
    //sure
    private func sageNotMeInfo(with model: floatedModel) {
        let name = model.biggest ?? ""
        let idnun = model.none ?? ""
        let time = model.goods ?? ""
        let listView = EnumListView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: listView, preferredStyle: .actionSheet)!
        self.present(alertVc, animated: true)
        
        listView.oneListView.phoneTx.text = name
        listView.twoListView.phoneTx.text = idnun
        listView.threeListView.timeBtn.setTitle(time, for: .normal)
        
        listView.threeListView.timeBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let time = listView.threeListView.timeBtn.titleLabel?.text ?? ""
            DatePickerHelper.showDayMonthYearPicker(on: self, defaultDateString: time) { time in
                listView.threeListView.timeBtn.setTitle(time, for: .normal)
            }
        }).disposed(by: disposeBag)
        
        
        listView.nextBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            let name = listView.oneListView.phoneTx.text ?? ""
            let idno = listView.twoListView.phoneTx.text ?? ""
            let time = listView.threeListView.timeBtn.titleLabel?.text ?? ""
            let dict = ["goods": time,
                        "none": idno,
                        "biggest": name,
                        "child": "11",
                        "tobuy": type]
            Task {
                await self.sassInfo(with: dict)
            }
        }).disposed(by: disposeBag)
        
    }
    
    
    private func sassInfo(with dict: [String: String]) async {
        KRProgressHUD.show(withMessage: "loading...")
        let man = NetworkManager()
        do {
            let result = try await man.request(.postData(endpoint: "/cbd/please", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            let likesnake = result.likesnake ?? ""
            if wanted == "0" || wanted == "00" {
                self.dismiss(animated: true) { [self] in
                    Task {
                        await self.getAuthInfo()
                        await self.stepInfo(with: productID, type: "3", cold: minImage, pollys: String(SCSignalManager.getCurrentTime()))
                    }
                }
            }
            KRProgressHUD.showMessage(likesnake)
        } catch  {
            KRProgressHUD.dismiss()
        }
    }
    
    private func getAuthInfo() async {
        KRProgressHUD.show(withMessage: "loading...")
        let man = NetworkManager()
        let dict = ["test": productID, "me": "1", "tell": "0"]
        do {
            let result =  try await man.request(.getData(endpoint: "/cbd/being", parameters: dict), responseType: BaseModel.self)
            let wanted = result.wanted ?? ""
            if wanted == "0" || wanted == "00" {
                if let model = result.floated {
                    let story = model.babies?.story ?? 0
                    let admiration = model.admiration ?? ""
                    if story == 1 {
                        bgView.leftView.oneLabel.text = model.babies?.tobuy ?? ""
                        bgView.leftView.leftImageView.image = UIImage(named: "compolegeimge")
                        self.imageBool = true
                    }
                    if !admiration.isEmpty {
                        self.faceBool = true
                        bgView.rightView.leftImageView.kf.setImage(with: URL(string: admiration))
                    }
                }
            }
            KRProgressHUD.dismiss()
        } catch {
            KRProgressHUD.dismiss()
        }
    }
    
}
