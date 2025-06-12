//
//  nettype.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/6/12.
//

import Alamofire
import Reachability

class NetInfoManager {
    
    enum NetworkStatus: String {
        case none = "NONE"
        case wifi = "WIFI"
        case cellular = "4G/5G"
    }
    
    typealias NetworkStatusHandler = (NetworkStatus) -> Void
    
    static let shared = NetInfoManager()
    
    private let reachability: Reachability
    
    private var networkStatusHandler: NetworkStatusHandler?
    private(set) var currentStatus: NetworkStatus = .none {
        didSet {
            networkStatusHandler?(currentStatus)
        }
    }
    
    init() {
        // Force try is acceptable here because Reachability only throws if hostname is invalid,
        // and we're using the default initializer
        reachability = try! Reachability()
        setupReachability()
    }
    
    deinit {
        stopMonitoring()
    }
    
    func observeNetworkStatus(_ handler: @escaping NetworkStatusHandler) {
        networkStatusHandler = handler
        // Immediately report current status to new observer
        handler(currentStatus)
    }
    
    func startMonitoring() throws {
        try reachability.startNotifier()
    }
    
    func stopMonitoring() {
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
    }
    
    private func setupReachability() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged),
            name: .reachabilityChanged,
            object: reachability
        )
        
        do {
            try startMonitoring()
        } catch {
            print("Reachability start notifier failed with error: \(error)")
        }
    }
    
    @objc private func networkStatusChanged() {
        switch reachability.connection {
        case .wifi:
            currentStatus = .wifi
        case .cellular:
            currentStatus = .cellular
        case .unavailable:
            currentStatus = .none
        }
    }
}
