//
//  MainViewOutput.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation

protocol MainViewOutput: Coordinated {
    var viewInput: MainViewInput? { get set }
    func getData()
    func moveToDetailVC(_ contact: ContactModel)
}
