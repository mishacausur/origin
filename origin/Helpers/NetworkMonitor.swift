//
//  NetworkMonitor.swift
//  origin
//
//  Created by Misha Causur on 11.03.2022.
//

import Foundation
import Network

@available(iOS 12.0, *)
final class NetworkMonitor {
    static let shared = NetworkMonitor()
    let queue = DispatchQueue.global()
    let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false
    public private(set) var connectionType: ConnetcionType?
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
    
    func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = nil
        }
    }
 }

enum ConnetcionType {
    case wifi
    case cellular
    case ethernet
}
