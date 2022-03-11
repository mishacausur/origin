//
//  NetworkMonitor.swift
//  origin
//
//  Created by Misha Causur on 11.03.2022.
//

import Foundation
import Network

@available(iOS 12.0, *)
struct NetworkMonitor {
    static let shared = NetworkMonitor()
    let queue = DispatchQueue.global()
    let monitor: NWPathMonitor
    public private(set) var isConnected: Bool = false
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = {
            
        }
    }
 }
