//
//  ContactTableViewCell.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import UIKit

final class ContactTableViewCell: UITableViewCell {
    
    private let nameLabel = UILabel().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = Font.font(.primary)
        $0.textColor = Color.color(.primary)
        $0.numberOfLines = 2
    }
    
    private let phoneLabel = UILabel().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = Font.font(.secondary)
        $0.textColor = Color.color(.secondary)
    }
    
    private let temperamentLabel = UILabel().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = Font.font(.secondary)
        $0.textColor = Color.color(.secondary)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func extendCellWithData(_ contact: ContactModel) {
        nameLabel.text = contact.name
        phoneLabel.text = contact.phone.numbered
        temperamentLabel.text = contact.temperament.rawValue.firstCapitalized
    }
    
    private func setupCell() {
        contentView.addSubviews(nameLabel, phoneLabel, temperamentLabel)
        
        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 18),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: temperamentLabel.leadingAnchor, constant: -6),
            nameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 220),
        
            phoneLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            phoneLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            phoneLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        
            temperamentLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            temperamentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)]
        
        NSLayoutConstraint.activate(constraints)
    }
}
