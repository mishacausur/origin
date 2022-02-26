//
//  DetailViewOutput.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation

protocol DetailViewOutput: Coordinated {
    var viewInput: DetailViewInput? { get set }
    var contact: ContactModel { get }
    func makeCall() 
}
