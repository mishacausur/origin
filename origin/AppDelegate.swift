//
//  AppDelegate.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var coodinator: Coordinating?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        if #available(iOS 12.0, *) {
            NetworkMonitor.shared.startMonitoring()
        } 
        let navigationController = UINavigationController()
        navigationController.navigationBar.prefersLargeTitles = true
        coodinator = Coordinator(navigationController: navigationController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        coodinator?.eventOccured(.start, contact: nil)
        return true
    }
    
}
