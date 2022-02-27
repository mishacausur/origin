//
//  NetworkManager.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {
    }
    
    func getData(_ links: [Links], completion: @escaping ([ContactModel]) -> Void) {
        var count = 0
        var list: [ContactModel] = []
        for link in links {
            guard let link = URL(string: link.rawValue) else { return }
            URLSession.shared.dataTask(with: link) { data, _, error in
                guard error == nil else {
                    print("an error occured \(String(describing: error?.localizedDescription))")
                    return
                }
                guard let contacts = data else { return }
                do {
                    let models = try JSONDecoder().decode([ContactModel].self, from: contacts)
                    list = list + models
                    if count == links.count {
                        completion(list)
                    }
                } catch let error {
                    print(error.localizedDescription)
                }
            }.resume()
            count += 1
        }
    }
}
