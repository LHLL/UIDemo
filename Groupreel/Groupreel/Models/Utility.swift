//
//  Utility.swift
//  Groupreel
//
//  Created by Lynn on 8/24/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit
import AudioToolbox
import CoreMotion

struct Utility {
    
    private init(){}
    
    private static let device = UIDevice.current
    private static var meter: CMMotionManager = {
        let m = CMMotionManager()
        m.accelerometerUpdateInterval = 0.5
        return m
    }()
    
    static var topViewController:UIViewController?{
        return topViewControllerWithRootViewController(rootViewController: UIApplication.shared.keyWindow?.rootViewController)
    }
    
    private static func topViewControllerWithRootViewController(rootViewController:UIViewController?) -> UIViewController?
    {
        if(rootViewController != nil)
        {
            // UITabBarController
            if let tabBarController = rootViewController as? UITabBarController,
                let selectedViewController = tabBarController.selectedViewController {
                return self.topViewControllerWithRootViewController(rootViewController: selectedViewController)
            }
            
            // UINavigationController
            if let navigationController = rootViewController as? UINavigationController ,let visibleViewController = navigationController.visibleViewController {
                return self.topViewControllerWithRootViewController(rootViewController: visibleViewController)
            }
            
            if ((rootViewController!.presentedViewController) != nil) {
                let presentedViewController = rootViewController!.presentedViewController;
                return self.topViewControllerWithRootViewController(rootViewController: presentedViewController!);
            }else
            {
                return rootViewController
            }
        }
        
        return nil
    }
    
    static var type:Bool {
        get{
            return vibrateType()
        }
    }
    
    static private func vibrateType()->Bool {
        if #available(iOS 10.0, *) {
            let deviceType = UIDevice.current.value(forKey: "_feedbackSupportLevel") as! Int
            return deviceType == 2
        }else{
            return false
        }
    }
    
    static func vibrate(){
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
    }
    
    static func monitorDeviceRotation(){
        meter.startAccelerometerUpdates( to: OperationQueue() ) { angle, _ in
            guard angle != nil else{return}
            guard abs(angle!.acceleration.x) > 0.85 else{return}
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "LandScape"),
                                            object: nil)
            meter.stopAccelerometerUpdates()
        }
    }
    
    static func toUTC(date:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d,yyyy h:mm a"
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let t = dateFormatter.string(from: dt!).appending("Z")        
        return t
    }
    
    static func fromUTC(date:String) -> String {
        var d = date
        if !d.contains("Z") {
            d.append("Z")
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: d)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "MMM d,yyyy h:mm a"
        
        return dateFormatter.string(from: dt!)
    }
    
    static func generateYearArray()->[String]{
        let today = Date()
        var results = [String]()
        var count = 0
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d,yyyy"
        while count < 101 {
            let tomorrow = Calendar.current.date(byAdding: .day, value: count, to: today)
            let t = formatter.string(from: tomorrow!)
            results.append(t)
            count += 1
        }
        
        return results
    }
    
    static func generateRandomStr()->String {
        let pool = "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var count = 0
        var result = "_"
        while count < 9 {
            let index = Int(arc4random_uniform(UInt32(pool.characters.count-1)))
            let c = pool.characters[pool.characters.index(pool.startIndex, offsetBy: index)]
            result.append(c)
            count += 1
        }
        return result
    }
    
    static func generateDate(from date:Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy | h a"
        return dateFormatter.string(from:date)
    }
}

enum PickerType{
    case time,date
}

extension PickerType{
    var rows:Int{
        switch self {
        case .time:
            return 1
        default:
            return 4
        }
    }
    
    var titles:[[String]]{
        switch self {
        case .time:
            return generateTimeArray()
        default:
            return generateDateArray()
        }
    }
    
    private func generateTimeArray()->[[String]] {
        var minutes = [""]
        var times = [String]()
        var count = 5
        while count <= 55 {
            minutes.append(", \(count) Minutes")
            count += 5
        }
        count = 0
        var hour = 0
        while hour < 10 {
            while count < minutes.count {
                let time = "\(hour) Hours\(minutes[count])".replacingOccurrences(of: "0 Hours, ", with: "").replacingOccurrences(of: "0 Hours", with: "")
                if !time.isEmpty {
                    times.append(time)
                }
                count += 1
            }
            hour += 1
            count = 0
        }
        times.append("10 Hours")
        return [times]
    }
    
    private func generateDateArray()->[[String]]{
        let today = Date()
        var results = [String]()
        var count = 0
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE MMM d"
        while count < 101 {
            let tomorrow = Calendar.current.date(byAdding: .day, value: count, to: today)
            let t = formatter.string(from: tomorrow!)
            results.append(t)
            count += 1
        }
        var minutes = ["00","05"]
        count = 10
        while count <= 55 {
            minutes.append("\(count)")
            count += 5
        }
        return [
            results,
            ["1","2","3","4","5","6","7","8","9","10","11","12"],
            minutes,
            ["AM","PM"]
        ]
    }
}
