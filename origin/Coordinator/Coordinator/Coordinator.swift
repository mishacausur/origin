//
//  Coordinator.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation
import UIKit

class Coordinator: Coordinating {
    var navigationController: UINavigationController?
    func eventOccured(_ event: Events) {
        switch event {
        case .start:
            start()
        case .dismiss:
            print("dismissed")
        case .pushDetailsViewController:
            print("pushed")
        }
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private func start() {
        let viewModel = MainViewModel()
        let vc = MainViewController(viewModel: viewModel)
        viewModel.coordinator = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
