//
//  DetailViewController.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import UIKit

class DetailViewController: UIViewController, ViewController {
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
        title = ""
    }
    
    override func loadView() {
        let view = DetailView()
        self.view = view
    }
    
    
}

extension DetailViewController: DetailViewInput {
    
}
