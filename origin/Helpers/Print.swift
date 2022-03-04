//
//  Print.swift
//  origin
//
//  Created by Misha Causur on 04.03.2022.
//

import Foundation

final class Print {
    static func printToConsole(_ message : String) {
           #if DEBUG
               print(message)
           #endif
       }
}
