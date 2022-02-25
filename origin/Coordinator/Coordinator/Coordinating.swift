//
//  Coordinating.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation
import UIKit

protocol Coordinating {
    var navigationController: UINavigationController? { get set }
    func eventOccured(_ event: Events)
}
