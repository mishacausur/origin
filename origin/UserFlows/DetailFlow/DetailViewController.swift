//
//  DetailViewController.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import UIKit

final class DetailViewController: UIViewController, ViewController {
    
    typealias RootView = DetailView
    var viewModel: DetailViewOutput
    
    init(viewModel: DetailViewOutput) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewInput = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view().phoneNumberTapped = { [weak self] in
            defer { withExtendedLifetime(self) {} }
            self?.viewModel.makeCall()
        }
        title = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never
       
        guard let coordinator = transitionCoordinator else {
            print("no transition coordinator :(")
            return
        }
        coordinator.animate { context in
            self.view().entartainment()
        } completion: { _ in
            print("animation is finished")
        }
    }
    
    override func loadView() {
        let view = DetailView(frame: .zero, contact: viewModel.contact)
        self.view = view
    }
}

extension DetailViewController: DetailViewInput {
}
