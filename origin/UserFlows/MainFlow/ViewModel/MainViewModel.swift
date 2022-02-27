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
    
    func getData() {
        if AppManager.shared.chackDate() {
            AppManager.shared.getDataFromServer { [weak self] result in
                defer { withExtendedLifetime(self) {} }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let contacts):
                        self?.viewInput?.configureViews(contacts.self)
                    case .failure(_):
                        self?.viewInput?.showError()
                    }
                }
            }
        } else {
            AppManager.shared.getdataFromDatabase {[weak self] result in
                defer { withExtendedLifetime(self) {} }
                DispatchQueue.main.async {
                    switch result {
                    case .success(let contacts):
                        self?.viewInput?.configureViews(contacts.self)
                    case .failure(_):
                        self?.viewInput?.showError()
                    }
                }
            }
        }
    }
    
    func moveToDetailVC(_ contact: ContactModel) {
        coordinator?.eventOccured(.pushDetailsViewController, contact: contact)
    }
}
