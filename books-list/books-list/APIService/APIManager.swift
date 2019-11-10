//
//  APIManager.swift
//  books-list
//
//  Created by Diuli Nobre on 10/11/19.
//  Copyright © 2019 Diuli Nobre. All rights reserved.
//

import Foundation

class APIManager {
    
    public static let shared = APIManager()
    private let request = Request<BooksAPI>()
    
    public func books(byAuthor author: String, completion: @escaping ([Item]?, NetworkError?) -> Void) {
        request.perform(BooksAPI.searchByAuthor(name: author)) { (requestResult: BookSearch?, error: NetworkError?) in
            guard let result = requestResult else { return completion(nil, error) }
            completion(result.items, nil)
        }
    }
    
    public func books(byName name: String, completion: @escaping ([Item]?, NetworkError?) -> Void) {
        request.perform(BooksAPI.searchByBook(name: name)) { (requestResult: BookSearch?, error: NetworkError?) in
            guard let result = requestResult else { return completion(nil, error) }
            completion(result.items, nil)
        }
    }
    
    public func books(byQuery query: String, completion: @escaping ([Item]?, NetworkError?) -> Void) {
        request.perform(BooksAPI.search(query: query)) { (requestResult: BookSearch?, error: NetworkError?) in
            guard let result = requestResult else { return completion(nil, error) }
            completion(result.items, nil)
        }
    }
    
    public func book(byId id: String, completion: @escaping (Item?, NetworkError?) -> Void) {
        request.perform(BooksAPI.search(query: id)) { (requestResult: BookSearch?, error: NetworkError?) in
            guard let result = requestResult else { return completion(nil, error) }
            let filtered = result.items.filter { (item) -> Bool in
                return item.id == id
            }
            guard let item = filtered.first else { return completion(nil, error) }
            completion(item, nil)
        }
    }
}
