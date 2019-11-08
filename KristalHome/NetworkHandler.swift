//
//  NetworkHandler.swift
//  KristalHome
//
//  Created by Prince Mathew on 08/11/19.
//  Copyright © 2019 Prince Mathew. All rights reserved.
//

import Foundation


class NetworkHandler: NSObject {
    static let shared = NetworkHandler()
    
    func makeRequest<T:Decodable>(to endPoint: URL,with model: T.Type,httpMethod: String, completion: @escaping (_ success: Bool,_ data: T?,_ error: Error?) -> Void) {
        let headers = [
            "x-rapidapi-host": "restcountries-v1.p.rapidapi.com",
            "x-rapidapi-key": "3cfd4aedbamsha3e2f6e97c61a24p1cea1fjsn16bbaa21244a"
        ]
        var request = URLRequest(url: endPoint, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headers
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if error == nil,
                let data = data,
                let modelData = try? JSONDecoder().decode(T.self, from: data)  {
                completion(true,modelData,nil)
            } else {
                completion(false,nil,error)
            }
        }
        task.resume()
    }
}
