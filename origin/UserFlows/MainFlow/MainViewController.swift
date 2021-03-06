//
//  ViewController.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import UIKit

final class MainViewController: UIViewController, ViewController {
    typealias RootView = MainView
    var viewModel: MainViewOutput
    let loader = LoadingViewController()
    
    init(viewModel: MainViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewInput = self
        add(loader)
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
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        definesPresentationContext = true
    }

    override func loadView() {
        let view = MainView()
        self.view = view
    }
}

extension MainViewController: MainViewInput {
    
    func configureViews(_ contacts: [ContactModel]) {
        loader.remove()
        view().setupView(contacts)
    }
    
    func showError() {
        view().showErrorView()
    }
}
