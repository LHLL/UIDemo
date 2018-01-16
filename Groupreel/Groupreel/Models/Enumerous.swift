//
//  Enumerous.swift
//  Groupreel
//
//  Created by Lynn on 1/11/18.
//  Copyright © 2018 Lynne. All rights reserved.
//

import Foundation

struct Enumerous {
    
    static func iterateEnum<T: Hashable>(_: T.Type) -> AnyIterator<T> {
        var i = 0
        return AnyIterator {
            let next = withUnsafeBytes(of: &i) { $0.load(as: T.self) }
            if next.hashValue != i { return nil }
            i += 1
            return next
        }
    }
}

enum Week:Int {
    case Sunday = 1
    case Monday
    case Tuesday
    case Wendsday
    case Thursday
    case Friday
    case Saturday
    
}

extension Week {
    var description:String {
        switch self {
        case .Sunday:
            return "Sun"
        case .Monday:
            return "Mon"
        case .Tuesday:
            return "Tue"
        case .Wendsday:
            return "Wen"
        case.Thursday:
            return "Thu"
        case .Friday:
            return "Fri"
        case .Saturday:
            return "Sat"
        }
    }
    
}

enum Month:Int {
    case Jan = 1
    case Feb
    case Mar
    case Apr
    case May
    case Jun
    case Jul
    case Aug
    case Sep
    case Oct
    case Nov
    case Dec
}

extension Month {
    var description:String {
        switch self {
        case .Jan:
            return "January"
        case .Feb:
            return "February"
        case .Mar:
            return "March"
        case .Apr:
            return "April"
        case .May:
            return "May"
        case .Jun:
            return "June"
        case .Jul:
            return "July"
        case .Aug :
            return "Augest"
        case .Sep:
            return "September"
        case .Oct:
            return "October"
        case .Nov:
            return "November"
        case .Dec:
            return "December"
        }
    }
}

enum ChosenMonth:Int {
    case Jan = 1
    case Feb
    case Mar
    case Apr
    case May
    case Jun
    case Jul
    case Aug
    case Sep
    case Oct
    case Nov
    case Dec
}

extension ChosenMonth {
    var description:String {
        switch self {
        case .Jan:
            return "Jan"
        case .Feb:
            return "Feb"
        case .Mar:
            return "Mar"
        case .Apr:
            return "Apr"
        case .May:
            return "May"
        case .Jun:
            return "Jun"
        case .Jul:
            return "Jul"
        case .Aug :
            return "Aug"
        case .Sep:
            return "Sep"
        case .Oct:
            return "Oct"
        case .Nov:
            return "No"
        case .Dec:
            return "Dec"
        }
    }
}
