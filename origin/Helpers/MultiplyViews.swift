//
//  MultiplyViews.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation
import UIKit

extension UIView {
    func addSubviews(_ subviews: UIView...)  {
        subviews.forEach{addSubview($0)}
    }
}
