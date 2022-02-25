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
    var contacts: [ContactModel]
    
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
    }
}

extension ContactsTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContactTableViewCell
        cell.extendCellWithData(contacts[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        completion?(contact)
    }
}
