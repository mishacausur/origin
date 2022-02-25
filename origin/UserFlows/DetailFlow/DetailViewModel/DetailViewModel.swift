//
//  DetailViewModel.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation

class DetailViewModel: DetailViewOutput {
    var contact: ContactModel
    var coordinator: Coordinator?
    var viewInput: DetailViewInput?
   
    init(_ contact: ContactModel) {
        self.contact = contact
    }
}
