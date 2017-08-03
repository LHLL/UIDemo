//
//  BlinkIndicator.swift
//  UIDemo
//
//  Created by Xu, Jay on 12/5/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

import UIKit

class BlinkIndicator: UIView {
    
    private var leftDot:UIView!
    private var midDot:UIView!
    private var rightDot:UIView!
    private var defaultWidth:CGFloat = 10
    
    var dotColor:UIColor = UIColor.black {
        didSet{
            setNeedsDisplay()
        }
    }
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(dotWidth:CGFloat, center:CGPoint) {
        super.init(frame:CGRect(x: center.x-3.5*dotWidth, y: center.y-1.5*dotWidth, width: 7*dotWidth, height: 3*dotWidth))
        self.defaultWidth = dotWidth
        leftDot = UIView(frame: CGRect(x: dotWidth, y: dotWidth, width: dotWidth, height: dotWidth))
        leftDot.backgroundColor = dotColor
        leftDot.layer.cornerRadius = leftDot.frame.width/2
        leftDot.alpha = 0.2
        midDot = UIView(frame: CGRect(x: dotWidth*3, y: dotWidth, width: dotWidth, height: dotWidth))
        midDot.backgroundColor = dotColor
        midDot.alpha = 0.2
        midDot.layer.cornerRadius = leftDot.frame.width/2
        rightDot = UIView(frame: CGRect(x: dotWidth*5, y: dotWidth, width: dotWidth, height: dotWidth))
        rightDot.backgroundColor = dotColor
        rightDot.alpha = 0.2
        rightDot.layer.cornerRadius = leftDot.frame.width/2
        addSubview(leftDot)
        addSubview(midDot)
        addSubview(rightDot)
    }
    
    func show(){
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
            self.leftDot.alpha = 1
        }) { (success) in
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                self.leftDot.alpha = 0.2
                self.midDot.alpha = 1
                }, completion: { (success) in
                    UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
                        self.midDot.alpha = 0.2
                        self.rightDot.alpha = 1
                        }, completion: { (success) in
                            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear, animations: {
                                self.rightDot.alpha = 0.2
                                }, completion: { (success) in
                                    self.show()
                            })
                    })
            })
        }
    }
    
    func stopAnimation(){
        leftDot.removeFromSuperview()
        midDot.removeFromSuperview()
        rightDot.removeFromSuperview()
        removeFromSuperview()
    }
}
