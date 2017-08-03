//
//  BouncingIndicator.swift
//  UIDemo
//
//  Created by Xu, Jay on 12/7/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

import UIKit

class BouncingIndicator: UIView {

    private var bat:UIView!
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
        super.init(frame: CGRect(x:center.x-radius,
                                 y: center.y-radius/2,
                                 width: radius*2,
                                 height: radius))
        bat = UIView(frame: CGRect(x: 20,
                                    y: 0,
                                    width: radius,
                                    height: radius))
        ball = UIView(frame: CGRect(x: radius*5/8*1.5,
                                    y: radius/4,
                                    width: radius/4,
                                    height: radius/4))

        bat.layer.cornerRadius = radius/2
        bat.layer.borderColor = UIColor.gray.cgColor
        bat.layer.borderWidth = 1
        bat.backgroundColor = UIColor.white
        addSubview(bat)
        bat.translatesAutoresizingMaskIntoConstraints = true
        bat.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        bat.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bat.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        bat.transform = CGAffineTransform(scaleX: 1.5, y: 0.4)
        
        ball.layer.cornerRadius = radius/8
        ball.backgroundColor = UIColor.gray
        addSubview(ball)
    }
    
    func show(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            self.ball.transform = CGAffineTransform(scaleX: 1.1, y: 0.8)
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                self.ball.transform = CGAffineTransform.identity
                self.ball.frame = CGRect(x: self.defaultRadius*5/8*1.5,
                                         y: -self.defaultRadius,
                                         width: self.defaultRadius/4,
                                         height: self.defaultRadius/4)
            }) { (success) in
                self.ball.transform = CGAffineTransform.identity
                DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                    self.ball.transform = CGAffineTransform(scaleX: 1.1, y: 0.8)
                    UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                        self.ball.transform = CGAffineTransform.identity
                        self.ball.frame = CGRect(x: self.defaultRadius*5/8*1.5,
                                                 y: self.defaultRadius/4,
                                                 width: self.defaultRadius/4,
                                                 height: self.defaultRadius/4)
                        }, completion: { (success) in
                            self.show()
                    })
                }
            }
        }
    }
    
    func stopAnimation(){
        ball.removeFromSuperview()
        bat.removeFromSuperview()
        removeFromSuperview()
    }
}
