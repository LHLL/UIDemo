//
//  NetworkIndicator.swift
//  MoveableTableView
//
//  Created by Xu, Jay on 9/21/16.
//  Copyright © 2016 Xu, Jay. All rights reserved.
//

import UIKit

class SpinIndicator: UIView {
    
    private var isInited = false
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init() {
        self.init(frame:CGRect(x: UIScreen.main.bounds.width/2-15, y: UIScreen.main.bounds.height/2, width: 30, height: 30))
    }
    
    init(center:CGPoint) {
        let origin = CGPoint(x: center.x-15, y: center.y-15)
        super.init(frame:CGRect(origin: origin, size: CGSize(width: 30, height: 30)))
    }
    
    func show(){
        if isInited {
            isHidden = false
        }else {
            let center = CGPoint(x: frame.width/2, y:frame.height/2)
            let outPath = UIBezierPath(arcCenter: center, radius: 40, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
            let inPath = UIBezierPath(arcCenter: center, radius: 33, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
            let spinPath = UIBezierPath(arcCenter: center, radius: 36, startAngle: 0, endAngle: CGFloat(2*M_PI), clockwise: true)
            
            let outerlayer = CAShapeLayer()
            outerlayer.path = outPath.cgPath
            outerlayer.fillColor = UIColor(red: 197/255.0, green: 205/255.0, blue: 217/255.0, alpha: 1.0).cgColor
            layer.addSublayer(outerlayer)
            
            let innerLayer = CAShapeLayer()
            innerLayer.path = inPath.cgPath
            innerLayer.fillColor = UIColor.white.cgColor
            layer.addSublayer(innerLayer)
            
            let spinnerLayer = CAShapeLayer()
            spinnerLayer.path = spinPath.cgPath
            spinnerLayer.fillColor = UIColor.clear.cgColor
            spinnerLayer.strokeColor = UIColor.gray.cgColor
            spinnerLayer.lineWidth = 5.5
            spinnerLayer.strokeStart = 0.0
            spinnerLayer.strokeEnd = 0.3
            layer.addSublayer(spinnerLayer)
            
            isInited = true
        }
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float(M_PI * 2.0)
        rotationAnimation.duration = 1
        rotationAnimation.repeatCount = Float.infinity
        
        layer.add(rotationAnimation, forKey: "spin")
    }
    
    func hide(){
        isHidden = true
    }
}
