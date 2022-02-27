//
//  ViewController.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import UIKit

class MainViewController: UIViewController, ViewController {
    typealias RootView = MainView
    var viewModel: MainViewOutput
    
    init(viewModel: MainViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewInput = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getData()
        title = "Contacts"
        view().completion = { [weak self] contact in
            defer { withExtendedLifetime(self) {} }
            self?.viewModel.moveToDetailVC(contact)
        }
        view().update = { [weak self] in
            defer { withExtendedLifetime(self) {} }
            self?.viewModel.getData()
        }
        navigationItem.searchController = view().searchController
        definesPresentationContext = true
    }

    override func loadView() {
        let view = MainView()
        self.view = view
    }
}

extension MainViewController: MainViewInput {
    
    func configureViews(_ contacts: [ContactModel]) {
        view().setupView(contacts)
    }
    
    func showError() {
        view().showErrorView()
    }
}
