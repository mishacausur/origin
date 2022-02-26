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
    
    var phoneNumberTapped: (() -> Void)?
    
    private let nameLabel = UILabel().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = Font.font(.headline)
        $0.textColor = Color.color(.primary)
        $0.numberOfLines = 0
    }
    
    private let dateLabel = UILabel().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = Font.font(.secondary)
        $0.textColor = Color.color(.secondary)
        $0.numberOfLines = 0
    }
    
    private let phoneLabel = UILabel().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = Font.font(.linked)
        $0.textColor = Color.color(.linked)
        $0.isUserInteractionEnabled = true
        $0.numberOfLines = 0
    }
    
    private let desciptionLabel = UILabel().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = Font.font(.secondary)
        $0.textColor = Color.color(.secondary)
        $0.textAlignment = .center
        $0.numberOfLines = 0
    }
    
    private let temperamentLabel = UILabel().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = Font.font(.secondary)
        $0.textColor = Color.color(.secondary)
        $0.numberOfLines = 0
    }
    
    let topSeparator = UIView().configure {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = Color.color(.secondary)
    }
    
    let bottomSeparator = UIView().configure {
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
        dateLabel.text = "\(contact.educationPeriod.start) - \(contact.educationPeriod.end)"
        temperamentLabel.text = contact.temperament.rawValue.firstCapitalized
        makePhoneLabelString(contact.phone.numbered)
        gestureCreator()
        self.addSubviews(nameLabel, dateLabel, temperamentLabel, topSeparator, phoneLabel, bottomSeparator, desciptionLabel)
        let constraints = [
            nameLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nameLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 350),
            
            dateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            temperamentLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 6),
            temperamentLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            topSeparator.topAnchor.constraint(equalTo: temperamentLabel.bottomAnchor, constant: 28),
            topSeparator.heightAnchor.constraint(equalToConstant: 0.5),
            topSeparator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            topSeparator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
            
            phoneLabel.topAnchor.constraint(equalTo: topSeparator.bottomAnchor, constant: 22),
            phoneLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            bottomSeparator.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 22),
            bottomSeparator.heightAnchor.constraint(equalToConstant: 0.5),
            bottomSeparator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            bottomSeparator.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12),
        
            desciptionLabel.topAnchor.constraint(equalTo: bottomSeparator.bottomAnchor, constant: 28),
            desciptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 22),
            desciptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -22)]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func makePhoneLabelString(_ phoneNumber: String) {
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "phone.fill.png")
        attachment.bounds = CGRect(x: 0, y: -3, width: 18, height: 18)
        let attachmentString = NSAttributedString(attachment: attachment)
        let phoneString = NSMutableAttributedString(string: "  \(phoneNumber)")
        phoneString.insert(attachmentString, at: 0)
        phoneLabel.attributedText = phoneString
    }
    
    private func gestureCreator() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(phoneTapped))
        phoneLabel.addGestureRecognizer(gesture)
    }
    
    @objc private func phoneTapped() {
        print("number tapped")
        phoneNumberTapped?()
    }
}