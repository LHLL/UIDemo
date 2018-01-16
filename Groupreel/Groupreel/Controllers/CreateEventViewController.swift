//
//  CreateEventViewController.swift
//  Groupreel
//
//  Created by Lynn on 12/6/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class CreateEventViewController: UIViewController {
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var manageBtn: UIButton!
    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var joinEventBtn: UIButton!
    @IBOutlet weak var creatEventBtn: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    private var gradientLayer: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
    }
    
    override func viewDidLayoutSubviews() {
        //gradient color
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [GroupreelColor.gradientStartColor,
                                GroupreelColor.gradientEndColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientView.layer.addSublayer(gradientLayer)
    }
    
    private func UISetup() {
        backgroundView.backgroundColor = GroupreelColor.backColor
        joinEventBtn.backgroundColor = GroupreelColor.blingGreen
        creatEventBtn.layer.cornerRadius = creatEventBtn.frame.size.height / 2
        joinEventBtn.layer.cornerRadius = joinEventBtn.frame.size.height / 2
        
        //tabBarViewImage setup
        cameraBtn.layer.borderWidth = 4
        cameraBtn.layer.borderColor = UIColor.white.cgColor
        cameraBtn.layer.cornerRadius = cameraBtn.frame.size.height / 2
        
        homeBtn.setImage(GroupreelImage.homeImage, for: .normal)
        eventBtn.setImage(GroupreelImage.eventImage, for: .normal)
        manageBtn.setImage(GroupreelImage.MessageImage, for: .normal)
        settingBtn.setImage(GroupreelImage.SettingImage, for: .normal)
        cameraBtn.setImage(GroupreelImage.cameraImage, for: .normal)
    }

    @IBAction func createEvent(_ sender: UIButton) {
        
    }
    
    @IBAction func joinEvent(_ sender: UIButton) {
        
    }
    
    
}
