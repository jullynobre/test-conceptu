//
//  Request.swift
//  books-list
//
//  Created by Diuli Nobre on 10/11/19.
//  Copyright © 2019 Diuli Nobre. All rights reserved.
//
import UIKit

// MARK: Class
/** Class responsible to handling networks request*/
class Request<T: EndPointType>: NetworkProtocol {
    
    // MARK: Variables
    private var task: URLSessionTask?
    
    // MARK: Functions
    /** Perform contains implemention body of request, but it must to have Api keys and required IDs*/
    func perform<U: Decodable>(_ endPoint: T, completion: @escaping (U?, NetworkError?) -> Void) {
        let session = URLSession.shared
        var request = URLRequest(url: endPoint.url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        request.httpMethod = "GET"
        
        self.task = session.dataTask(with: request, completionHandler: { (data, _, error) in
            guard let responseData = data, error == nil else {
                print("Request Error:", error!.localizedDescription)
                return DispatchQueue.main.async {completion(nil, NetworkError.failRequest)}
            }
            
            do {
                let decodeObject = try JSONDecoder().decode(U.self, from: responseData)
                
                DispatchQueue.main.async {
                    completion(decodeObject, nil)
                }
            } catch {
                print("Decoding error:", error)
                DispatchQueue.main.async {completion(nil, NetworkError.failRequest)}
            }
        })
        
        self.task?.resume()
        
    }
    /** Call this function when you wanna cancel your taks call. */
    func cancel() {
        self.task?.cancel()
    }
    
    func loadImage(from urlSring: String, completion: @escaping (UIImage?, NetworkError?) -> Void) {
        guard let url = URL(string: urlSring) else { return }
        let session = URLSession.shared
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30.0)
        request.httpMethod = "GET"
        
        self.task = session.dataTask(with: request) { (data, _, error) in
            guard let responseData = data, error == nil else {
                
                return DispatchQueue.main.async {
                    print("Request Error:", error!.localizedDescription)
                    completion(nil, NetworkError.failRequest)
                    
                }
            }
            guard let uiImage = UIImage(data: responseData) else {
                return DispatchQueue.main.async { completion(nil, NetworkError.failRequest) }
            }
            DispatchQueue.main.async { completion(uiImage, nil) }
        }
        self.task?.resume()
    }
}
