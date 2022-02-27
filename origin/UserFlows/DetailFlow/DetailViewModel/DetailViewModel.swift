//
//  DetailViewModel.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation
import UIKit

class DetailViewModel: DetailViewOutput {

    var contact: ContactModel
    var coordinator: Coordinator?
    var viewInput: DetailViewInput?
    
    init(_ contact: ContactModel) {
        self.contact = contact
    }
    
    func makeCall() {
        let number = contact.phone.numberedUnspaced
        guard let url = URL(string: "tel://\(number)") else {
            print("not calling =/")
            return
        }
        print("calling")
        UIApplication.shared.open(url)
    }
    
}
