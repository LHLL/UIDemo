//
//  BreathIndicator.swift
//  UIDemo
//
//  Created by Xu, Jay on 12/2/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

import UIKit

class BreathIndicator: UIView {
    
    // Internal class like Java package, this class can be accessed only within this BreathIndicator.
    class BlinkView: UIView {
        override var frame: CGRect {
            didSet{
                layer.cornerRadius = frame.width/2
                guard superview != nil else {
                    return
                }
            }
        }
        
        private var shrinkTimer:Timer?
        private var expandTimer:Timer?
        
        private var radius:CGFloat = 50
        private var count:CGFloat = 1
        private var centerPoint:CGPoint?
        
        private override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        convenience init() {
            self.init(frame:CGRect.zero)
        }
        
        init(radius:CGFloat,center:CGPoint) {
            let origin = CGPoint(x: center.x-radius/2, y: center.y-radius/2)
            super.init(frame:CGRect(origin: origin, size: CGSize(width: radius, height: radius)))
            self.radius = radius
            self.centerPoint = center
            self.backgroundColor = UIColor.white
        }
        
        func startBlink(){
            shrinkTimer = Timer.scheduledTimer(timeInterval: 1/48, target: self, selector: #selector(shrink), userInfo: nil, repeats: true)
        }
        
        @objc private func shrink(){
            count += 1
            let instantRadius = radius - count
            guard instantRadius != 10 else {
                count = 1
                shrinkTimer!.invalidate()
                expandTimer = Timer.scheduledTimer(timeInterval: 1/48, target: self, selector: #selector(expand), userInfo: nil, repeats: true)
                return
            }
            frame = CGRect(origin: CGPoint(x: center.x - instantRadius/2, y: center.y - instantRadius/2), size: CGSize(width: instantRadius, height: instantRadius))
        }
        
        @objc private func expand(){
            count += 1
            let instantRadius = 10 + count
            guard instantRadius != radius else {
                count = 1
                expandTimer!.invalidate()
                shrinkTimer = Timer.scheduledTimer(timeInterval: 1/48,
                                                   target: self,
                                                   selector: #selector(shrink),
                                                   userInfo: nil,
                                                   repeats: true)
                return
            }
            frame = CGRect(origin: CGPoint(x: center.x - instantRadius/2, y: center.y - instantRadius/2),
                           size: CGSize(width: instantRadius, height: instantRadius))
        }
    }
    
    private var blinkView:BlinkView!
    override var frame: CGRect {
        didSet{
            layer.cornerRadius = frame.width/2
            guard superview != nil else {
                return
            }
        }
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(radius:CGFloat, color:UIColor, center: CGPoint) {
        super.init(frame:CGRect(origin: CGPoint(x: center.x - radius/2, y: center.y - radius/2), size: CGSize(width: radius, height: radius)))
        backgroundColor = color
        blinkView = BlinkView(radius: radius-10, center:CGPoint(x: radius/2, y: radius/2))
        addSubview(blinkView)
    }
    
    func show(){
        blinkView!.startBlink()
    }
    
    func stopAnimation(){
        blinkView.removeFromSuperview()
        removeFromSuperview()
    }

}
