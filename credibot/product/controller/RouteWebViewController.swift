//
//  RouteWebViewController.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/6/10.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa
import StoreKit

class RouteWebViewController: BaseViewController {
    
    var pageUrl: String = ""
    
    private let scriptNames = ["parrotVan", "jellyPapa", "iceUmbrel", "sorghumMa", "breadRadi", "yogurtVan"]
    
    lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let userContentController = WKUserContentController()
        scriptNames.forEach { userContentController.add(self, name: $0) }
        configuration.userContentController = userContentController
        let preferences = WKPreferences()
        preferences.javaScriptCanOpenWindowsAutomatically = false
        preferences.minimumFontSize = 10.0
        configuration.preferences = preferences
        configuration.processPool = WKProcessPool()
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        let scrollView = webView.scrollView
        scrollView.isMultipleTouchEnabled = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.bounces = false
        scrollView.alwaysBounceVertical = false
        scrollView.delaysContentTouches = false
        
        webView.isOpaque = false
        webView.backgroundColor = .clear
        webView.allowsBackForwardNavigationGestures = true
        
        return webView
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.trackTintColor = UIColor.init(colorHex: "#EEEEEE")
        progressView.progressTintColor = UIColor.init(colorHex: "#FFC250")
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor.init(colorHex: "#F1F5F9")
        view.addSubview(backBtn)
        view.addSubview(nameLabel)
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
        
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(15.pix())
        }
        
        backBtn.rx.tap.subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            if self.webView.canGoBack {
                self.webView.goBack()
            }else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }).disposed(by: disposeBag)
        
        if let url = URL(string: pageUrl.replacingOccurrences(of: " ", with: "")) {
            webView.load(URLRequest(url: url))
        }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(webView.snp.top)
            make.height.equalTo(1.pix())
        }
        
        webView.rx.observe(String.self, "title")
            .observe(on: MainScheduler.instance)
            .subscribe(with: self, onNext: { owner, title in
                owner.nameLabel.text = title
            })
            .disposed(by: disposeBag)
        
        webView.rx.observe(Double.self, "estimatedProgress")
            .compactMap { $0 }
            .share()
            .subscribe(with: self, onNext: { owner, progress in
                let progressFloat = Float(progress)
                owner.progressView.setProgress(progressFloat, animated: true)
                owner.progressView.isHidden = false
                if progress == 1.0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) { [weak owner] in
                        owner?.progressView.setProgress(0.0, animated: false)
                        owner?.progressView.isHidden = true
                    }
                }
            })
            .disposed(by: disposeBag)
        
    }
    
}

extension RouteWebViewController: WKScriptMessageHandler, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let messageName = message.name
        switch messageName {
        case "parrotVan":
            let body = message.body as? [String]
            let productID = body?.first ?? ""
            let coc = String(SCSignalManager.getCurrentTime())
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                Task {
                    await self.stepInfo(with: productID, type: "10", cold: coc, pollys: coc)
                }
            }
            break
        case "sorghumMa":
            goRoutePage()
            break
        case "breadRadi":
            let phone = UserDefaults.standard.object(forKey: "phone") as? String ?? ""
            breadRadiEmail(with: phone)
            break
        case "yogurtVan":
            startInfo()
            break
        case "jellyPapa":
            let pageUrl = message.body as? String ?? ""
            jellyPapaPageUrl(with: pageUrl)
            break
        case "iceUmbrel":
            self.navigationController?.popToRootViewController(animated: true)
            break
        default:
            break
        }
    }
    
}

extension RouteWebViewController {
    
    private func startInfo() {
        if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
    }
    
    private func breadRadiEmail(with phone: String) {
        
    }
    
    private func jellyPapaPageUrl(with pageUrl: String) {
        if pageUrl.contains(EnumList.fishAlmondQu) {
            goRoutePage()
        }else if pageUrl.contains(EnumList.xwatermelonS) {
            if let url = URL(string: pageUrl), let productID = GestureParameter.producdUrlStr(url: url) {
                Task {
                    await self.getProdectDetailInfoToVc(to: productID)
                }
            }
        }
    }
    
    private func goRoutePage() {
        NotificationCenter.default.post(name: NSNotification.Name("changeVc"), object: nil)
    }
    
}

class EnumList {
    static let fishAlmondQu = "fishAlmondQu"
    static let xwatermelonS = "xwatermelonS"
}

class GestureParameter {
  static func producdUrlStr(url: URL) -> String? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        return components.queryItems?.last?.value
    }
}
