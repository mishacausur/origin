//
//  Request.swift
//  origin
//
//  Created by Misha Causur on 05.03.2022.
//

import Foundation

protocol Request {
    associatedtype Response
    associatedtype Error: Swift.Error
    
    typealias Handler = (Result<Response, Error>) -> Void
    
    func perform(then handler: @escaping Handler)
}

struct AnyRequest<Response, Error: Swift.Error> {
    typealias Handler = (Result<Response, Error>) -> Void
    
    let perform: (@escaping Handler) -> Void
    let handler: Handler
}

class RequestQueue<Response, Error: Swift.Error> {
    private typealias TypeErasedRequest = AnyRequest<Response, Error>
    
    private var queue = [TypeErasedRequest]()
    private var ongoing: TypeErasedRequest?
    func add<R: Request>(_ request: R, handler: @escaping R.Handler) where R.Response == Response, R.Error == Error {
        let typeErased = AnyRequest(perform: request.perform, handler: handler)
        switch ongoing {
        case .none:
            queue.append(typeErased)
        case .some(_):
            perform(typeErased)
        }
        //        guard ongoing == nil else {
        //            queue.append(typeErased)
        //            return
        //        }
        //        perform(typeErased)
    }
    
    private func perform(_ request: TypeErasedRequest) {
        ongoing = request
        
        request.perform { [weak self] result in
            request.handler(result)
            self?.ongoing = nil
        }
    }
}
