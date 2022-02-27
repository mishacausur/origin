//
//  MainView.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation
import UIKit

class MainView: UIView {
    
    var completion: ((ContactModel) -> Void)?
    var update: (() -> Void)?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private let activity = UIActivityIndicatorView().configure {
        $0.hidesWhenStopped = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private let errorView = UIView().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        $0.backgroundColor = .black
        $0.alpha = 0.6
    }
    
    private let errorLabel = UILabel().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = Font.font(.primary)
        $0.textColor = .white
        $0.text = "Нет подключения к сети"
        $0.numberOfLines = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addActivityIndicator()
       
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showErrorView() {
        self.addSubviews(errorView, errorLabel)
        let constraints = [
            errorView.heightAnchor.constraint(equalToConstant: 64),
            errorView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            errorView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            errorView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -42),
        
            errorLabel.centerXAnchor.constraint(equalTo: errorView.centerXAnchor),
            errorLabel.centerYAnchor.constraint(equalTo: errorView.centerYAnchor)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func setupView(_ contacts: [ContactModel]) {
        let contactTableView = ContactsTableView(frame: .zero, contacts: contacts)
        searchController.searchResultsUpdater = contactTableView
        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.delegate = contactTableView
        self.addSubview(contactTableView)
        contactTableView.translatesAutoresizingMaskIntoConstraints = false
        [contactTableView.topAnchor.constraint(equalTo: self.topAnchor),
         contactTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
         contactTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
         contactTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)].forEach { $0.isActive = true }
        contactTableView.completion = { [weak self] contact in
            defer { withExtendedLifetime(self) {} }
            self?.completion?(contact)
        }
        contactTableView.update = { [weak self] in
            defer { withExtendedLifetime(self) {} }
            self?.update?()
        }
        activity.stopAnimating()
    }
    
    private func addActivityIndicator() {
        self.addSubview(activity)
        activity.startAnimating()
        [activity.centerXAnchor.constraint(equalTo: self.centerXAnchor),
         activity.centerYAnchor.constraint(equalTo: self.centerYAnchor)].forEach { $0.isActive = true }
    }
}
