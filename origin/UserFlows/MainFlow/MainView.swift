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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addActivityIndicator()
       
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
