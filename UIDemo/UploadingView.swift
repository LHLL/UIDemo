//
//  UploadingView.swift
//  UploadButton
//
//  Created by Xu, Jay on 8/31/17.
//  Copyright © 2017 Xu, Jay. All rights reserved.
//

import UIKit

class UploadingView: UIView {

    @IBOutlet weak var cloudImg: UIImageView!
    @IBOutlet weak var arrowImg: UIImageView!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    private let cloudColor:UIColor = .cyan
    private let arrowColor:UIColor = .black
    private let cancel = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    private let info = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    private var isDone = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let cloud = IonIcons.image(withIcon: ion_cloud,
                                   iconColor: cloudColor,
                                   iconSize: 25,
                                   imageSize: CGSize(width: 25, height: 25))
        cloudImg.image = cloud
        
        let arrow = IonIcons.image(withIcon: ion_arrow_up_a,
                                   iconColor: arrowColor,
                                   iconSize: 12,
                                   imageSize: CGSize(width: 12, height: 12))
        arrowImg.image = arrow
        
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(move)))
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showOptions)))
        cancel.addTarget(self, action: #selector(cancelUpload), for: .touchUpInside)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let btnFrame = CGRect(x: -50, y: -50, width: 80, height: 80)
        if btnFrame.contains(point) {
            return self
        }
        return nil
    }
    
    func startAnimation(){
        bottom.constant = 0
        let group = CAAnimationGroup()
        let opa = CABasicAnimation(keyPath: "opacity")
        opa.fromValue = 0
        opa.toValue = 1
        
        let move = CABasicAnimation(keyPath: "position")
        move.fromValue = NSValue(cgPoint: arrowImg.layer.position)
        var p = arrowImg.layer.position
        p.y -= 12
        move.toValue = p
        
        group.animations = [opa,move]
        group.duration = 1.5
        group.repeatCount = Float.infinity
        group.isRemovedOnCompletion = true
        group.fillMode = kCAFillModeForwards
        arrowImg.layer.add(group, forKey: nil)
    }
    
    func done(){
        let check = IonIcons.image(withIcon: ion_checkmark,
                                   iconColor: arrowColor,
                                   iconSize: 12,
                                   imageSize: CGSize(width: 12, height: 12))
        arrowImg.layer.removeAllAnimations()
        arrowImg.image = check
        bottom.constant = -5
        isDone = true
        if subviews.contains(cancel) {
            leftAnimation()
            rightAnimation()
        }
    }
    
    //MARK:IBActions
    dynamic private func move(sender:UIPanGestureRecognizer){
        let location = sender.location(in: superview!)
        center = location
    }
    
    dynamic private func showOptions(sender:UITapGestureRecognizer){
        guard !isDone else{return}
        leftAnimation()
        rightAnimation()
    }
    
    dynamic private func cancelUpload(){
        leftAnimation()
        rightAnimation()
    }
    
    dynamic private func showInfo(){
        leftAnimation()
        rightAnimation()
    }
    
    //MARK:Animations
    private func leftAnimation(){
        isUserInteractionEnabled = false
        guard !subviews.contains(cancel) else{
            let group = CAAnimationGroup()
            let opa = CABasicAnimation(keyPath: "opacity")
            opa.fromValue = 1
            opa.toValue = 0
            
            let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.isAdditive = true
            rotation.fromValue = 0
            rotation.toValue = Double.pi*10000
            
            let move = CABasicAnimation(keyPath: "position")
            move.fromValue = NSValue(cgPoint: cancel.layer.position)
            var p = cancel.layer.position
            p.y += 30
            p.x += 30
            move.toValue = p
            
            group.animations = [opa,move,rotation]
            group.duration = 0.4
            group.isRemovedOnCompletion = false
            group.fillMode = kCAFillModeForwards
            cancel.layer.add(group, forKey: nil)
            DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {
                self.cancel.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                self.cancel.layer.removeAllAnimations()
                self.cancel.removeFromSuperview()
                self.isUserInteractionEnabled = true
            }
            return
        }
        let delete = IonIcons.image(withIcon: ion_close_circled,
                                    iconColor: arrowColor,
                                    iconSize: 20,
                                    imageSize: CGSize(width: 20, height: 20))
        cancel.setImage(delete, for: .normal)
        cancel.layer.cornerRadius = 10
        insertSubview(cancel, at: 0)
        
        let group = CAAnimationGroup()
        let opa = CABasicAnimation(keyPath: "opacity")
        opa.fromValue = 0
        opa.toValue = 1
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.isAdditive = true
        rotation.fromValue = 0
        rotation.toValue = Double.pi*10000
        
        let move = CABasicAnimation(keyPath: "position")
        move.fromValue = NSValue(cgPoint: cancel.layer.position)
        var p = cancel.layer.position
        p.y -= 30
        p.x -= 30
        move.toValue = p
        
        group.animations = [opa,move,rotation]
        group.duration = 0.4
        group.isRemovedOnCompletion = false
        group.fillMode = kCAFillModeForwards
        cancel.layer.add(group, forKey: nil)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {
            self.cancel.frame = CGRect(x: -30, y: -30, width: 20, height: 20)
            self.isUserInteractionEnabled = true
        }
    }
    
    private func rightAnimation(){
        guard !subviews.contains(info) else{
            let group = CAAnimationGroup()
            let opa = CABasicAnimation(keyPath: "opacity")
            opa.fromValue = 1
            opa.toValue = 0
            
            let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
            rotation.isAdditive = true
            rotation.fromValue = 0
            rotation.toValue = Double.pi*10000
            
            let move = CABasicAnimation(keyPath: "position")
            move.fromValue = NSValue(cgPoint: info.layer.position)
            var p = info.layer.position
            p.y += 30
            p.x -= 40
            move.toValue = p
            
            group.animations = [opa,move,rotation]
            group.duration = 0.4
            group.isRemovedOnCompletion = false
            group.fillMode = kCAFillModeForwards
            info.layer.add(group, forKey: nil)
            DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {
                self.info.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
                self.info.layer.removeAllAnimations()
                self.info.removeFromSuperview()
            }
            return
        }
        let delete = IonIcons.image(withIcon: ion_information_circled,
                                    iconColor: arrowColor,
                                    iconSize: 20,
                                    imageSize: CGSize(width: 20, height: 20))
        info.setImage(delete, for: .normal)
        info.layer.cornerRadius = 10
        insertSubview(info, at: 0)
        
        let group = CAAnimationGroup()
        let opa = CABasicAnimation(keyPath: "opacity")
        opa.fromValue = 0
        opa.toValue = 1
        
        let rotation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.isAdditive = true
        rotation.fromValue = 0
        rotation.toValue = Double.pi*10000
        
        let move = CABasicAnimation(keyPath: "position")
        move.fromValue = NSValue(cgPoint: info.layer.position)
        var p = info.layer.position
        p.y -= 30
        p.x += 40
        move.toValue = p
        
        group.animations = [opa,move,rotation]
        group.duration = 0.4
        group.isRemovedOnCompletion = false
        group.fillMode = kCAFillModeForwards
        info.layer.add(group, forKey: nil)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.4) {
            self.info.frame = CGRect(x: 40, y: -30, width: 20, height: 20)
        }
    }
}
