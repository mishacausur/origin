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
    func eventOccured(_ event: Events, contact: ContactModel?) {
        switch event {
        case .start:
            start()
        case .dismiss:
            dismiss()
        case .pushDetailsViewController:
            guard let contact = contact else {
                return
            }
            toDetailViewController(contact)
        }
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private func start() {
        let viewModel = MainViewModel()
        let viewController = MainViewController(viewModel: viewModel)
        viewModel.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func toDetailViewController(_ contact: ContactModel) {
        let viewModel = DetailViewModel(contact)
        let viewController = DetailViewController(viewModel: viewModel)
        viewModel.coordinator = self
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func dismiss() {
        navigationController?.dismiss(animated: true)
    }
}
