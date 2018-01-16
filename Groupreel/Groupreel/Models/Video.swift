//
//  Video.swift
//  Groupreel
//
//  Created by Lynn on 11/6/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import Foundation

struct Video {
    let name:String
    let time:String
    let thumb:UIImage
//    let movie:UIImage
    
    init(name:String, time:String, thumb:UIImage) {
        self.name = name
        self.time = time
        self.thumb = thumb
    }
}

