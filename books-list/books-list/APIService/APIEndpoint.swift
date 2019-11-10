//
//  APIEndpoint.swift
//  books-list
//
//  Created by Diuli Nobre on 10/11/19.
//  Copyright © 2019 Diuli Nobre. All rights reserved.
//

import Foundation

/** Emum with API's possibles resquest case */
enum BooksAPI {
    case searchByBook(name: String)
    case searchByAuthor(name: String)
    case searchIsbn(isbn: String)
    case search(query: String)
}

/** Protocol to API url and path management */
public protocol EndPointType {
    var url: URL { get }
    var path: String { get }
}

extension BooksAPI: EndPointType {
    static let apiAdress: String = "https://www.googleapis.com/books/v1/"
    
    var url: URL {
        return URL(string: self.path)!
    }
    
    var path: String {
        let settings = "&printType=books&orderBy=relevance&langRestrict=" + (Locale.current.languageCode ?? "")
        let key = "key=AIzaSyBahtGDraspWc_A-m47UTOrOzjy9jkHOuY"
        switch self {
        //Each request case should complete them self URL
        case .search(let query):
            let formattedQuery = query.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            return BooksAPI.apiAdress + "volumes?" + key + "&q=" + formattedQuery!.lowercased() + settings
        case .searchByAuthor(let name):
            let formattedQuery = name.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            return BooksAPI.apiAdress + "volumes?" + key + "&q=inauthor:" + formattedQuery!.lowercased() + settings
        case .searchByBook(let name):
            let formattedQuery = name.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            return BooksAPI.apiAdress + "volumes?" + key + "&q=intitle:" + formattedQuery!.lowercased() + settings
        case .searchIsbn(let isbn):
            let formattedIsbn = isbn.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            return BooksAPI.apiAdress + "volumes?" + key + "&q=isbn%" + formattedIsbn!.lowercased()
        }
    }
}
