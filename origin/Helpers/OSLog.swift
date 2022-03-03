//
//  OSLog.swift
//  origin
//
//  Created by Misha Causur on 03.03.2022.
//

import Foundation
import os.log

@available(iOS 12.0, *)
extension OSLog {
    static let point = OSLog(subsystem: "performance", category: .pointsOfInterest)
}
