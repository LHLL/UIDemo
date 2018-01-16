//
//  WebUtility.swift
//  MLADemo
//
//  Created by Xu, Jay on 5/8/17.
//  Copyright © 2017 Wells Fargo. All rights reserved.
//

import Foundation

struct WebUtility {
    
    func prepareForAuthenticationPayload(_ userName:String,_ password:String)->[String:Any]{
        return [
            "user_id":userName,
            "credential":password,
        ]
    }
    
    func prepareForRegistration(name:String,password:String)->[String:String]{
        return [
            "username":name,
            "password":password,
            "passwordRepeat":password
        ]
    }
    
    private func generateTimeStamp()->String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
        let date = Date()
        let dateStr = formatter.string(from: date)
        return dateStr
    }
    
    private func generateMessageID()->String {
        var charPool = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var i = 0
        var messageID = ""
        while i < 20 {
            let index = Int(arc4random_uniform(UInt32(charPool.characters.count)))
            let head = charPool.startIndex
            let start = charPool.characters.index(head, offsetBy: index)
            let end = charPool.index(head, offsetBy: index+1)
            messageID.append(String(charPool[start..<end]))
            i += 1
        }
        return messageID
    }
    
    func platform() -> String {
        var size = 0
        sysctlbyname("hw.machine", nil, &size, nil, 0)
        var machine = [CChar](repeating: 0,  count: size)
        sysctlbyname("hw.machine", &machine, &size, nil, 0)
        let platform = String(cString: machine).replacingOccurrences(of: ",", with: "_")
        return platform
    }
}

enum GRError:Error {
    case Unknow
    case Normal(String)
}
