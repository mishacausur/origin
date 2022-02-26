//
//  Controller.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation
import UIKit

protocol ViewController {
    associatedtype RootView: UIView
}

extension ViewController where Self: UIViewController {
    func view() -> RootView {
        return self.view as! RootView
    }
}
