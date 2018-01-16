//
//  GroupreelImages.swift
//  Groupreel
//
//  Created by Lynn on 12/11/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import Foundation

struct GroupreelImage {
    static let homeImage = IonIcons.image(withIcon: ion_android_home, iconColor: UIColor(displayP3Red: 111/255.0, green: 195/255.0, blue: 116/255.0, alpha: 1), iconSize: 30, imageSize: CGSize(width: 30, height: 30))
    
    static let eventImage = IonIcons.image(withIcon: ion_calendar, iconColor: UIColor.white, iconSize: 30, imageSize: CGSize(width: 30, height: 30))
    
    static let MessageImage = IonIcons.image(withIcon: ion_email, iconColor: UIColor.white, iconSize: 30, imageSize: CGSize(width: 30, height: 30))
    
    static let SettingImage = IonIcons.image(withIcon: ion_ios_gear_outline, iconColor: UIColor.white, iconSize: 30, imageSize: CGSize(width: 30, height: 30))
    
    static let cameraImage = IonIcons.image(withIcon: ion_record, iconColor: UIColor(displayP3Red: 232/255.0, green: 93/255.0, blue: 90/255.0, alpha: 1), iconSize: 62, imageSize: CGSize(width: 62, height: 62))
    
    static let errorImage = IonIcons.image(withIcon: ion_ios_information_outline, iconColor: GroupreelColor.errorColor, iconSize: 15, imageSize: CGSize(width: 15, height: 15))
}
