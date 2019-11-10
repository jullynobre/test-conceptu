//
//  NetworkProtocol.swift
//  books-list
//
//  Created by Diuli Nobre on 10/11/19.
//  Copyright © 2019 Diuli Nobre. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case failRequest
    
    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .failRequest: return "Applicantion cannot request external data"            
        }
    }
}

protocol NetworkProtocol {
    associatedtype EndPoint: EndPointType
    func perform<T: Decodable>(_ route: EndPoint, completion: @escaping (T?, NetworkError?) -> Void)
    func cancel()
}

