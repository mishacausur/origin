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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(_ contacts: [ContactModel]) {
        let contactTableView = ContactsTableView(frame: .zero, contacts: contacts)
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
    }
 
}

