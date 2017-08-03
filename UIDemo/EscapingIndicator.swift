//
//  EscapingIndicator.swift
//  UIDemo
//
//  Created by Xu, Jay on 12/5/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

import UIKit

class EscapingIndicator: UIView {

    private var ball:UIView!
    private var defaultRadius:CGFloat = 20
    private var defaultCenter:CGPoint = CGPoint(x: UIScreen.main.bounds.width/2,
                                                y: UIScreen.main.bounds.height/2)
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(radius:CGFloat, center:CGPoint) {
        defaultRadius = radius
        defaultCenter = center
        super.init(frame: CGRect(x:center.x-2*radius,
                                 y: center.y-radius/2,
                                 width: radius*4,
                                 height: radius))
        ball = UIView(frame: CGRect(x: 0,
                                    y: 0,
                                    width: radius,
                                    height: radius))
        ball.layer.cornerRadius = radius/2
        ball.backgroundColor = UIColor.black
        addBarriers()
        addSubview(ball)
    }
    
    func show(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            self.ball.transform = CGAffineTransform(scaleX: 1.1, y: 0.8)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                self.ball.transform = CGAffineTransform.identity
                self.ball.frame = CGRect(x: 3*self.defaultRadius,
                                         y: 0,
                                         width: self.defaultRadius,
                                         height: self.defaultRadius)
            }) { (success) in
                self.ball.transform = CGAffineTransform.identity
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    self.ball.transform = CGAffineTransform(scaleX: 1.1, y: 0.8)
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                        self.ball.transform = CGAffineTransform.identity
                        self.ball.frame = CGRect(x: 0,
                                                 y: 0,
                                                 width: self.defaultRadius,
                                                 height: self.defaultRadius)
                        }, completion: { (success) in
                            self.show()
                    })
                }
            }
        }
    }
    
    func stopAnimation(){
        ball.removeFromSuperview()
        removeFromSuperview()
    }
    
    private func addBarriers(){
        let weight:CGFloat = 1
        
        let lineViewLeft = UIView()
        addSubview(lineViewLeft)
        lineViewLeft.backgroundColor = UIColor.black
        lineViewLeft.translatesAutoresizingMaskIntoConstraints = false
        lineViewLeft.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        lineViewLeft.topAnchor.constraint(equalTo: topAnchor).isActive = true
        lineViewLeft.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        lineViewLeft.widthAnchor.constraint(equalToConstant: weight).isActive = true
        
        let lineViewRight = UIView()
        addSubview(lineViewRight)
        lineViewRight.backgroundColor = UIColor.black
        lineViewRight.translatesAutoresizingMaskIntoConstraints = false
        lineViewRight.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        lineViewRight.topAnchor.constraint(equalTo: topAnchor).isActive = true
        lineViewRight.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        lineViewRight.widthAnchor.constraint(equalToConstant: weight).isActive = true
    }

}
