//
//  NetworkManager.swift
//  origin
//
//  Created by Misha Causur on 25.02.2022.
//

import Foundation

class Requester: Request {
   
    typealias Response = [ContactModel]
    
    typealias Error = Swift.Error
    
    func perform(then handler: @escaping Handler) {
        handler(.success([ContactModel]()))
    }
}

class NetworkManager {
    
    typealias Completion = (Result <[ContactModel], Error>) -> Void
    
    let request = RequestQueue<[ContactModel], Error>()
    
    let requester = Requester()
    
    static let shared = NetworkManager()
    
    private init() {}
    
    final func getData(_ links: [Links], completion: @escaping Completion) {
        let linkers = links.compactMap { URL.init(string: $0.rawValue) }
        var count = linkers.count
        var list: [ContactModel] = []
        for link in linkers {
            URLSession.shared.dataTask(with: link) { data, _, error in
                guard error == nil else {
                    Print.printToConsole("an error occured \(String(describing: error?.localizedDescription))")
                    return
                }
                guard let contacts = data else { return }
                do {
                    let models = try JSONDecoder().decode([ContactModel].self, from: contacts)
                    list.append(contentsOf: models)
                    if count == 0 {
                        self.request.add(self.requester) { _ in print("requseter") }
                        completion(.success(list))
                    }
                } catch let error {
                    completion(.failure(error))
                    print(error.localizedDescription)
                }
            }.resume()
            count -= 1
        }
    }
}
