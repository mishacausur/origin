//
//  StyleGuide.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation
import UIKit

enum Font {
    case primary
    case headline
    case secondary
    case linked
    
    static func font(_ font: Font) -> UIFont {
        switch font {
        case .primary:
            return UIFont.systemFont(ofSize: 18, weight: .bold)
        case .headline:
            return UIFont.systemFont(ofSize: 28, weight: .medium)
        case .secondary:
            return UIFont.systemFont(ofSize: 16, weight: .regular)
        case .linked:
            return UIFont.systemFont(ofSize: 16, weight: .medium)
        }
    }
}

enum Color {
    case primary
    case secondary
    case linked
    
    static func color(_ color: Color) -> UIColor {
        switch color {
        case .primary:
            return UIColor.black
        case .secondary:
            return UIColor.systemGray
        case .linked:
            return UIColor.systemBlue
        }
    }
}

