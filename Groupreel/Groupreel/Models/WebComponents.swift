//
//  WebComponents.swift
//  Groupreel
//
//  Created by Lynn on 8/30/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import Foundation

struct RegistrationRequest:Request {
    var host:String = "http://groupreel-dev.eastus.cloudapp.azure.com:8080/groupreel/"
    var path:String = "account/"
    var url:URL
    var method:String = "POST"
    var header:[[String:Any]]?
    var body:[String:Any]?
    
    var token:String?{
        didSet{
            body!["iosToken"] = token
        }
    }
    
    typealias response = RegistrationResponse
    
    init(name:String, pass:String,first:String,last:String,phone:String) {
        url = URL(string: host + path)!
        body = [
            "password": pass,
            "passwordRepeat": pass,
            "username": name,
            "iosToken": token ?? "NA",
            "firstName":first,
            "lastName":last,
            "phone":phone
        ]
    }
}

struct RegistrationResponse:Decodeable {
    var error:GRError?
    var activated = false
    var associatedEventIDs = [String]()
    static func parse(data:Data,success:Bool)->RegistrationResponse?{
        if success {
            var result = RegistrationResponse()
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            if let flag = json["activated"] as? Bool{
                result.activated = flag
            }
            if let ids = json["eventIds"] as? [String] {
                result.associatedEventIDs = ids
            }
            return result
        }else{
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            let e = json["message"] as! String
            var r = RegistrationResponse()
            r.error = GRError.Normal(e)
            return r
        }
    }
}

struct AuthRequest:Request {
    var host:String = "http://groupreel-dev.eastus.cloudapp.azure.com:8080/groupreel/"
    var path:String = "account/login"
    var url:URL
    var method:String = "POST"
    var header:[[String:Any]]?
    var body:[String:Any]?
    var token:String?{
        didSet{
            body!["iosToken"] = token
        }
    }
    
    typealias response = AuthResponse
    
    init(name:String, pass:String) {
        body = [
            "password": pass,
            "username": name,
            "iosToken": token ?? "NA"
        ]
        url = URL(string: host + path)!
    }
}

struct AuthResponse:Decodeable {
    var error:GRError?
    var associatedEventIDs = [String]()
    static func parse(data:Data,success:Bool)->AuthResponse?{
        if success {
            var result = AuthResponse()
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            if let ids = json["eventIds"] as? [String] {
                result.associatedEventIDs = ids
            }
            return result
        }else{
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            let e = json["message"] as! String
            var r = AuthResponse()
            r.error = GRError.Normal(e)
            return r
        }
    }
}

struct AllEventRequest:Request {
    var host:String = "http://groupreel-dev.eastus.cloudapp.azure.com:8080/groupreel/"
    var path:String
    var url:URL
    var method:String = "GET"
    var header:[[String:Any]]?
    var body:[String:Any]?
    
    typealias response = AllEventResponse
    
    init(with userName:String) {
        path = "account/\(userName)/events"
        url = URL(string: host + path)!
    }
}

struct AllEventResponse:Decodeable {
    var events:[Event]?
    var error:GRError?
    static func parse(data:Data,success:Bool)->AllEventResponse?{
        if success {
            var temp = [Event]()
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [[String:Any]]
            for dict in json {
                let e = Event(with: dict)
                temp.append(e)
            }
            var result = AllEventResponse()
            result.events = temp
            return result
        }else{
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            let e = json["message"] as! String
            var r = AllEventResponse()
            r.error = GRError.Normal(e)
            return r
        }
    }
}

struct EventRequest:Request {
    var host:String = "http://groupreel-dev.eastus.cloudapp.azure.com:8080/groupreel/"
    var path:String = "event/"
    var url:URL
    var method:String = "GET"
    var header:[[String:Any]]?
    var body:[String:Any]?
    
    typealias response = EventResponse
    
    init(id:String) {
        url = URL(string: host + path + id)!
    }
}

struct EventResponse:Decodeable {
    var event:Event?
    var error:GRError?
    static func parse(data:Data,success:Bool)->EventResponse?{
        if success {
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            let e = Event(with: json)
            var result = EventResponse()
            result.event = e
            return result
        }else{
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            let e = json["message"] as! String
            var r = EventResponse()
            r.error = GRError.Normal(e)
            return r
        }
    }
}

struct CreatEventRequest:Request {
    var host:String = "http://groupreel-dev.eastus.cloudapp.azure.com:8080/groupreel/"
    var path:String = "event/"
    var url:URL
    var method:String = "POST"
    var header:[[String:Any]]?
    var body:[String:Any]?
    
    typealias response = CreatEventResponse
    
    init(event:Event) {
        body = event.toDict()
        url = URL(string: host + path)!
    }
}

struct CreatEventResponse:Decodeable {
    var event:Event?
    var error:GRError?
    static func parse(data:Data,success:Bool)->CreatEventResponse?{
        if success {
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            let e = Event(with: json)
            var result = CreatEventResponse()
            result.event = e
            return result
        }else{
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            let e = json["message"] as! String
            var r = CreatEventResponse()
            r.error = GRError.Normal(e)
            return r
        }
    }
}

struct PurchaseRequest:Request {
    var host:String = "http://groupreel-dev.eastus.cloudapp.azure.com:8080/groupreel/"
    var path:String = "event/"
    var url:URL
    var method:String = "PUT"
    var header:[[String:Any]]?
    var body:[String:Any]?
    
    typealias response = PurchaseResponse
    
    init(eventID:String,p:Payment) {
        path = "/event/\(eventID)/payment"
        body = p.toDict()
        url = URL(string: host + path)!
    }
}

struct PurchaseResponse:Decodeable {
    var event:Event?
    var error:GRError?
    static func parse(data:Data,success:Bool)->PurchaseResponse?{
        if success {
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            let e = Event(with: json)
            var result = PurchaseResponse()
            result.event = e
            return result
        }else{
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            let e = json["message"] as! String
            var r = PurchaseResponse()
            r.error = GRError.Normal(e)
            return r
        }
    }
}

struct UpdateEventRequest:Request {
    var host:String = "http://groupreel-dev.eastus.cloudapp.azure.com:8080/groupreel/"
    var path:String = "event/"
    var url:URL
    var method:String = "PUT"
    var header:[[String:Any]]?
    var body:[String:Any]?
    
    typealias response = UpdateEventResponse
    
    init(event:String,b:[String:Any]) {
        path = "/event/\(event)/entry"
        body = b
        url = URL(string: host + path)!
    }
}

struct UpdateEventResponse:Decodeable {
    var event:Event?
    var error:GRError?
    static func parse(data:Data,success:Bool)->UpdateEventResponse?{
        if success {
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            let e = Event(with: json)
            var result = UpdateEventResponse()
            result.event = e
            return result
        }else{
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            let e = json["message"] as! String
            var r = UpdateEventResponse()
            r.error = GRError.Normal(e)
            return r
        }
    }
}

struct AddGuestRequest:Request {
    var host:String = "http://groupreel-dev.eastus.cloudapp.azure.com:8080/groupreel/"
    var path:String = "event/"
    var url:URL
    var method:String = "PUT"
    var header:[[String:Any]]?
    var body:[String:Any]?
    
    typealias response = AddGuestResponse
    
    init(eventId:String,user:String) {
        path = "event/\(eventId)/guest"
        body = ["user":[user]]
        url = URL(string: host + path)!
    }
}

struct AddGuestResponse:Decodeable {
    var event:Event?
    var error:GRError?
    static func parse(data:Data,success:Bool)->AddGuestResponse?{
        if success {
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            let e = Event(with: json)
            var result = AddGuestResponse()
            result.event = e
            return result
        }else{
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            let e = json["message"] as! String
            var r = AddGuestResponse()
            r.error = GRError.Normal(e)
            return r
        }
    }
}

struct PriceRequest:Request {
    var host:String = "http://groupreel-dev.eastus.cloudapp.azure.com:8080/groupreel/"
    var path:String = "pricing/"
    var url:URL
    var method:String = "POST"
    var header:[[String:Any]]?
    var body:[String:Any]?
    
    typealias response = PriceResponse
    
    init(duration:Int,promo:String = "") {
        body = [
            "promoCode": promo,
            "seconds": duration
            ]
        url = URL(string: host + path)!
    }
}

struct PriceResponse:Decodeable {
    var price:Double = 0
    var savings:Double = 0
    var error:GRError?
    static func parse(data:Data,success:Bool)->PriceResponse?{
        if success {
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            var result = PriceResponse()
            if let sa = json["savings"] as? Double{
                result.savings = sa
            }
            if let to = json["total"] as? Double{
                result.price = to
            }
            return result
        }else{
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            let e = json["message"] as! String
            var r = PriceResponse()
            r.error = GRError.Normal(e)
            return r
        }
    }
}

struct PromotionRequest:Request {
    var host:String = "http://groupreel-dev.eastus.cloudapp.azure.com:8080/groupreel/"
    var path:String = "promotion/code/"
    var url:URL
    var method:String = "GET"
    var header:[[String:Any]]?
    var body:[String:Any]?
    
    typealias response = PromotionResponset
    
    init(promo:String) {
        path += promo
        url = URL(string: host + path)!
    }
}

struct PromotionResponset:Decodeable {
    // 10% off is returned as 0.1
    var discount:Double = 0
    var error:GRError?
    static func parse(data:Data,success:Bool)->PromotionResponset?{
        if success {
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            var result = PromotionResponset()
            guard let flag = json["active"] as? Bool,flag else{
                result.error = GRError.Normal("Promotion code is expired or not activated yet.")
                return result
            }
            if let off = json["percentOff"] as? Double{
                result.discount = off
            }
            return result
        }else{
            let json = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
            let e = json["message"] as! String
            var r = PromotionResponset()
            r.error = GRError.Normal(e)
            return r
        }
    }
}

