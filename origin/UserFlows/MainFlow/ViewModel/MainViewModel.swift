//
//  ViewModel.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation

class MainViewModel: MainViewOutput {
    
    var viewInput: MainViewInput?
    
    var coordinator: Coordinator?
    
    let queue = DispatchQueue(label: "background", qos: .background, attributes: .concurrent)
    
    func getData() {
        queue.async {
            NetworkManager.shared.getData([.one, .two, .three]) { [weak self] contacts in
                defer { withExtendedLifetime(self) {} }
                DispatchQueue.main.async {
                    self?.viewInput?.configureViews(contacts.sorted { $0.name < $1.name })
                }
            }
        }
    }
    
    func moveToDetailVC(_ contact: ContactModel) {
        coordinator?.eventOccured(.pushDetailsViewController, contact: contact)
    }
}
