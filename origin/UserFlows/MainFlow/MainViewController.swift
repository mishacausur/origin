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
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func loadView() {
           let view = MainView()
           self.view = view
       }

}

