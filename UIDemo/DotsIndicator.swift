//
//  DotsIndicator.swift
//  UIDemo
//
//  Created by Xu, Jay on 12/5/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

import UIKit

class DotsIndicator: UIView {
    
    private var leftDot:UIView!
    private var midDot:UIView!
    private var rightDot:UIView!
    private var defaultWidth:CGFloat = 10
    
    var dotColor:UIColor = UIColor.green {
        didSet{
            leftDot.backgroundColor = dotColor
            midDot.backgroundColor = dotColor
            rightDot.backgroundColor = dotColor
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
        leftDot.backgroundColor = UIColor.green
        midDot = UIView(frame: CGRect(x: dotWidth*3, y: dotWidth, width: dotWidth, height: dotWidth))
        midDot.backgroundColor = UIColor.green
        rightDot = UIView(frame: CGRect(x: dotWidth*5, y: dotWidth, width: dotWidth, height: dotWidth))
        rightDot.backgroundColor = UIColor.green
        addSubview(leftDot)
        addSubview(midDot)
        addSubview(rightDot)
    }
    
    func show(){
       UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
        self.leftDot.frame = CGRect(x: self.defaultWidth-self.defaultWidth/2, y: self.defaultWidth-self.defaultWidth/2, width: self.defaultWidth*2 , height: self.defaultWidth*2)
        }) { (success) in
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                self.leftDot.frame = CGRect(x: self.defaultWidth, y: self.defaultWidth, width: self.defaultWidth, height: self.defaultWidth)
                self.midDot.frame = CGRect(x: 3*self.defaultWidth-self.defaultWidth/2, y: self.defaultWidth-self.defaultWidth/2, width: self.defaultWidth*2, height: self.defaultWidth*2)
                }, completion: { (success) in
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                        self.midDot.frame = CGRect(x: 3*self.defaultWidth, y: self.defaultWidth, width: self.defaultWidth, height: self.defaultWidth)
                        self.rightDot.frame = CGRect(x: 5*self.defaultWidth-self.defaultWidth/2, y: self.defaultWidth-self.defaultWidth/2, width: self.defaultWidth*2, height: self.defaultWidth*2)
                        }, completion: { (success) in
                            UIView.animate(withDuration: 0.3, delay: 0.1, options: .curveLinear, animations: {
                                self.rightDot.frame = CGRect(x: 5*self.defaultWidth, y: self.defaultWidth, width: self.defaultWidth, height: self.defaultWidth)
                                }, completion: { (success) in
                                    self.show()
                            })
                    })
            })
        }
    }
    
    func stopAnimation(){
        leftDot.removeFromSuperview()
        rightDot.removeFromSuperview()
        midDot.removeFromSuperview()
        removeFromSuperview()
    }
}
