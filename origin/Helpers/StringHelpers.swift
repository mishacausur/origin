//
//  StringHelpers.swift
//  origin
//
//  Created by Misha Causur on 26.02.2022.
//

import Foundation

extension StringProtocol {
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
    var numbered: String { replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "") }
    var numberedUnspaced: String { replacingOccurrences(of: "(", with: "").replacingOccurrences(of: ")", with: "").replacingOccurrences(of: " ", with: "").replacingOccurrences(of: "-", with: "") }
}
