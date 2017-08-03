//
//  WebServiceHandler.swift
//  Wallet10
//
//  Created by Xu, Jay on 11/18/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

import Foundation

class WebServiceHandler:HTTPClient {
    
    func send<T : Request>(r: T, completionHandler: @escaping (Result<T.Response>) -> Void) {
        let request = URLRequest(url: r.url,
                                 cachePolicy: .returnCacheDataElseLoad,
                                 timeoutInterval: 120) as URLRequest
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (data, response, error) in
            if data != nil {
                completionHandler(.success(T.Response.parse(data: data!)!))
            }else if error != nil {
                completionHandler(.failure(error!))
            }
        }
        task.resume()
    }
}

protocol HTTPClient {
    func send<T:Request>(r:T,completionHandler:@escaping(Result<T.Response>) -> Void)
}

protocol Request {
    var url:URL{get}
    associatedtype Response:Decodeable
}

protocol Decodeable {
    static func parse(data:Data)->Self?
}

enum Result<T> {
    case success(T)
    case failure(Error)
}
