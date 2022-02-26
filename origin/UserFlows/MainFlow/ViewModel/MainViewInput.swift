//
//  MainViewInput.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation

protocol MainViewInput {
    var viewModel: MainViewOutput { get }
    func configureViews(_ contacts: [ContactModel])
}
