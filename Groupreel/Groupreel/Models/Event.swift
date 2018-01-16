//
//  Event.swift
//  Groupreel
//
//  Created by Lynn on 8/30/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import Foundation

struct Event {
    var name:String!
    var origin:String!
    var drafter:String!
    var start:String!
    var ends:String!
    var duration:Int = 0
    var remaining:Int = 0
    var videos:[Video] = []
    var guests:[String] = []
    var id:String?
    var modifier:String!
    var modifyTime:String!
    var payment:[Payment] = []
    var editorNote = ""
    var musicNote = ""
    var promotionalCode = ""
    
    init(with dict:[String:Any]) {
        name = dict["name"] as! String
        modifier = dict["updatedBy"] as! String
        modifyTime = dict["updatedAt"] as! String
        start = Utility.fromUTC(date: (dict["startAt"] as! String))
        if let payments = dict["payments"] as? [[String:Any]]{
            for p in payments{
                self.payment.append(Payment(with: p))
            }
        }
        id = dict["id"] as? String
        guests = dict["guests"] as! [String]
        let videoes = dict["entries"] as! [[String:Any]]
        for v in videoes {
            self.videos.append(Video(with: v))
        }
        ends = Utility.fromUTC(date: (dict["endAt"] as! String))
        duration = dict["duration"] as! Int
        remaining = dict["durationLeft"] as! Int
        drafter = dict["createdBy"] as! String
        origin = dict["createdAt"] as! String
        editorNote = dict["musicNotes"] as? String ?? ""
        musicNote = dict["editorNotes"] as? String ?? ""
    }
    
    init() {}
    
    func toDict()->[String:Any]{
        return [
            "endAt":ends!,
            "name":name!,
            "startAt":start!,
            "payments":payment.map{$0.toDict()},
            "createdBy":drafter
        ]
    }
    
    func addEntry()->[String:Any] {
        return [
            "endAt":Utility.toUTC(date: ends!),
            "name":name!,
            "startAt":Utility.toUTC(date: start!),
            "id":id!,
            "createdBy":drafter,
            "entries":videos.map{$0.toDict()}
        ]
    }
}

struct Video {
    var duration:Int
    var timeStamp:String = ""
    var owner:String
    
    init(d:Int,owner:String) {
        duration = d
        self.owner = owner
    }
    
    init(with dict:[String:Any]) {
        duration = dict["duration"] as! Int
        timeStamp = dict["enteredAt"] as! String
        owner = dict["username"] as! String
    }
    
    func toDict()->[String:Any] {
        return [
            "duration":duration,
            "username":owner
        ]
    }
}

struct Payment{
    var amount:Double
    var timeStamp:String?
    var duration:Int
    var token:String
    var type = "PAYPAL"
    var payee:String
    var promo:String = ""
    
    init(a:Double, d:Int,token:String,p:String) {
        amount = a
        duration = d
        self.token = token
        payee = p
    }
    
    init(with dict:[String:Any]) {
        amount = dict["amount"] as! Double
        timeStamp = dict["createdAt"] as? String
        duration = dict["duration"] as! Int
        token = dict["token"] as! String
        payee = dict["username"] as! String
        promo = dict["promotionalCode"] as! String
    }
    
    func toDict()->[String:Any]{
        return [
            "amount":amount,
            "duration":duration,
            "token":token,
            "type":type,
            "username":payee,
            "promotionalCode":promo
        ]
    }
}
