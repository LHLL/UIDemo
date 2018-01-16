//
//  Extensions.swift
//  Groupreel
//
//  Created by Lynn on 8/24/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

extension UIView{
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x:self.center.x - 4.0, y:self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x:self.center.x + 4.0, y:self.center.y))
        layer.add(animation, forKey: "position")
    }
}


extension String{
    
    var isEmail:Bool {
        let emailFormat = "[a-zA-Z0-9._]{2,60}+@[a-zA-Z0-9_]+\\.[a-zA-Z]{2,10}"
        let regex = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        let result = regex.evaluate(with: self)
        return result
    }
}
