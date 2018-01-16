//
//  Event.swift
//  Groupreel
//
//  Created by Lynn on 1/10/18.
//  Copyright © 2018 Lynne. All rights reserved.
//

import Foundation

struct Event {
    let header:String
    let title:String
    let startTime:String
    let endTime:String
    let startDate:String
    let endDate:String
    
    init(header:String, title:String, startTime:String, endTime:String, startDate:String, endDate:String) {
        self.header = header
        self.title = title
        self.startTime = startTime
        self.startDate = startDate
        self.endTime = endTime
        self.endDate = endDate
    }
}
