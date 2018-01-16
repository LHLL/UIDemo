//
//  WebServiceHandler.swift
//  WebServiceTest
//
//  Created by Xu, Jay on 5/5/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit
import SystemConfiguration
import Security

protocol Request {
    var host:String{get}
    var path:String{get}
    var url:URL{get}
    var method:String{get}
    var header:[[String:Any]]?{get}
    var body:[String:Any]?{get}
    
    associatedtype response:Decodeable
}

protocol Decodeable {
    static func parse(data:Data,success:Bool)->Self?
}

typealias WebCompletion<T:Request> = (_ success:Bool,_ response:T.response?,_ error:GRError?)->Void

class WebServiceHandler: NSObject {
    
    private var serverError:String? = "Cannot establish secure connection with App and Server, please try later."
    
    func send<T:Request>(r:T,completion:@escaping WebCompletion<T>) {
        let url = r.url
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = r.method
        request.timeoutInterval = 120
        if r.header != nil{
            for header in r.header! {
                let key = header.keys.first
                request.setValue(header[key!] as? String, forHTTPHeaderField: key!)
            }
        }
        if r.body != nil {
            if let user = r.body!["user"] as? [String]{
                let bodyData = try! JSONSerialization.data(withJSONObject: user, options: .prettyPrinted)
                var bodyStr = String(data: bodyData, encoding: .utf8)
                bodyStr = bodyStr?.replacingOccurrences(of: "\\", with: "")
                request.httpBody = bodyStr!.data(using: .utf8)!
            }else{
                let bodyData = try! JSONSerialization.data(withJSONObject: r.body!, options: .prettyPrinted)
                var bodyStr = String(data: bodyData, encoding: .utf8)
                bodyStr = bodyStr?.replacingOccurrences(of: "\\", with: "")
                request.httpBody = bodyStr!.data(using: .utf8)!
            }
        }
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                completion(false, nil, .Normal(error!.localizedDescription))
                return
            }
            guard response is HTTPURLResponse else{
                assert(false, "Response is not http response")
                completion(false, nil, .Unknow)
                return
            }
            guard (response as! HTTPURLResponse).statusCode != 404 else {
                assert(false, "404 NOT FOUND")
                completion(false, nil, .Normal("System Unavailable"))
                return
            }
            
            guard (response as! HTTPURLResponse).statusCode != 400 else {
                completion(false,nil,.Normal("Bad Request"))
                return
            }
            guard data != nil else {
                assert(false, "Response body is empty")
                completion(false, nil, .Unknow)
                return
            }
            guard (response as! HTTPURLResponse).statusCode == 200 else {
                let res = T.response.parse(data: data!, success: false)
                completion(false, res, nil)
                return
            }
            let res = T.response.parse(data: data!, success: true)
            guard res != nil else {
                assert(false, "Invalid Json Response")
                completion(false, nil, .Normal("System Unavailable"))
                return
            }
            completion(true, res, nil)
        }
        task.resume()
    }
}
