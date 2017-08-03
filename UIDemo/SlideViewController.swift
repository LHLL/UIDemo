//
//  SlideViewController.swift
//  UIDemo
//
//  Created by Xu, Jay on 1/20/17.
//  Copyright © 2017 Wells Fargo. All rights reserved.
//

import UIKit

class SlideViewController: UIViewController {
    
    @IBOutlet var segLabels: [UILabel]!
    @IBOutlet weak var stackContainer: UIStackView!
    @IBOutlet weak var contentView: UIView!
    
    private var viewControllers = [UIViewController]()
    private var index:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let vc1 = UIViewController()
        vc1.view.backgroundColor = UIColor.red
        let vc2 = UIViewController()
        vc2.view.backgroundColor = UIColor.blue
        let vc3 = UIViewController()
        vc3.view.backgroundColor = UIColor.green
        let vc4 = UIViewController()
        vc4.view.backgroundColor = UIColor.gray
        viewControllers.append(vc1)
        viewControllers.append(vc2)
        viewControllers.append(vc3)
        viewControllers.append(vc4)
        
        showSelectedView(index: index)
        automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        segLabels.first?.drawBotBorder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapHanlder(_ sender: UITapGestureRecognizer) {
        for label in segLabels {
            let rect:CGRect = label.frame
            label.eraseBotBorder()
            if rect.contains(sender.location(in: stackContainer)) {
                label.drawBotBorder()
                index = segLabels.index(of: label)!
                showSelectedView(index: index)
            }
        }
    }
    
    @IBAction func nextSeg(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .left {
            guard index != 3 else {return}
            segLabels[index].eraseBotBorder()
            segLabels[index+1].drawBotBorder()
            showSelectedView(index: index+1)
            index += 1
            
        }else {
            guard index != 0 else {return}
            segLabels[index].eraseBotBorder()
            segLabels[index-1].drawBotBorder()
            showSelectedView(index: index-1)
            index -= 1
        }
    }
    
    private func showSelectedView(index: Int){
        let vc = viewControllers[index]
        guard contentView.subviews.count == 0 else {
            for index in 0..<contentView.subviews.count {
                let sv = contentView.subviews[index]
                sv.removeFromSuperview()
            }
            contentView.addSubview(vc.view)
            return
        }
        contentView.addSubview(vc.view)
    }
}

extension UILabel {
    func drawBotBorder(){
        let line = UIBezierPath()
        line.move(to: CGPoint(x: 0, y: frame.height-8))
        line.addLine(to: CGPoint(x: frame.width, y: frame.height-8))
        line.lineWidth = 1
        let lineLayer = CAShapeLayer()
        lineLayer.path = line.cgPath
        lineLayer.strokeColor = UIColor.red.cgColor
        layer.addSublayer(lineLayer)
    }
    
    func eraseBotBorder(){
        layer.sublayers?.removeAll()
    }
}
