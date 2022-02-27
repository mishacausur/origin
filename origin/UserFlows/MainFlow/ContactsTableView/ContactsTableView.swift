//
//  ContactsTableView.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation
import UIKit

class ContactsTableView: UIView {
    
    var completion: ((ContactModel) -> Void)?
    var update: (()->())?
    var contacts: [ContactModel]
    private var filteredContacts: [ContactModel] = []
    private var isFiltered: Bool = false
    
    private lazy var tableView = UITableView(frame: .zero, style: .grouped).configure {
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .white
        $0.separatorStyle = .singleLine
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.register(ContactTableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    init(frame: CGRect, contacts: [ContactModel]) {
        self.contacts = contacts
        super.init(frame: frame)
        self.backgroundColor = .white
        configureView()
        for i in contacts {
            var contact = i
            try! AppDatabase.shared.saveContact(&contact)
        }
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        self.addSubview(tableView)
        [tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
         tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
         tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
         tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)].forEach { $0.isActive = true}
        configureRefreshControl()
    }
    
    private func configureRefreshControl() {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
    
    @objc private func handleRefreshControl() {
        DispatchQueue.main.async {
            self.update?()
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
}

extension ContactsTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltered {
            return filteredContacts.count
        } else {
            return contacts.count
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContactTableViewCell
        if isFiltered {
            cell.extendCellWithData(filteredContacts[indexPath.row])
        } else {
            cell.extendCellWithData(contacts[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isFiltered {
            let contact = filteredContacts[indexPath.row]
            completion?(contact)
        } else {
            let contact = contacts[indexPath.row]
            completion?(contact)
        }
    }
}

extension ContactsTableView: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        if !text.isEmpty {
            isFiltered = true
        } else {
            isFiltered = false
        }
        searchContact(text)
        
    }
    
    private func searchContact(_ searchText: String) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            defer { withExtendedLifetime(self) {} }
            if searchText.isNumeric {
                self.filteredContacts = self.contacts.filter({ contact in
                    contact.phone.numberedUnspaced.contains(searchText.numberedUnspaced)
                })
            } else {
                self.filteredContacts = self.contacts.filter({ contact in
                    contact.name.lowercased().contains(searchText.lowercased())
                })
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        
    }
}
