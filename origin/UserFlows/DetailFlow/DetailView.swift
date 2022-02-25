//
//  DetailView.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation
import UIKit

class DetailView: UIView {
    
    var contact: ContactModel
    
    private let nameLabel = UILabel().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = Font.font(.headline)
        $0.textColor = Color.color(.primary)
        $0.numberOfLines = 0
    }
    
    private let desciptionLabel = UILabel().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = Font.font(.secondary)
        $0.textColor = Color.color(.secondary)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    let separator = UIView().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.color(.secondary)
    }
    
    init(frame: CGRect, contact: ContactModel) {
        self.contact = contact
        super.init(frame: frame)
        configureView()
        self.backgroundColor = .white
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        nameLabel.text = contact.name
        desciptionLabel.text = contact.biography
        self.addSubviews(nameLabel, separator, desciptionLabel)
        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 350),
            
            separator.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            separator.heightAnchor.constraint(equalToConstant: 0.5),
            separator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            separator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
        
            desciptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),
            desciptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22),
            desciptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -22)]
        
        NSLayoutConstraint.activate(constraints)
    }
}
