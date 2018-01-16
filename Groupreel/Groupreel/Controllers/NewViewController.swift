//
//  NewViewController.swift
//  Groupreel
//
//  Created by Lynn on 1/10/18.
//  Copyright © 2018 Lynne. All rights reserved.
//

import UIKit

class NewViewController: UIViewController {
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var manageBtn: UIButton!
    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        // Do any additional setup after loading the view.
    }

    private func UISetup() {
        backgroundView.backgroundColor = GroupreelColor.backColor
        
        //tabBarViewImage setup
        cameraBtn.layer.borderWidth = 4
        cameraBtn.layer.borderColor = UIColor.white.cgColor
        cameraBtn.layer.cornerRadius = cameraBtn.frame.size.height / 2
        
        homeBtn.setImage(GroupreelImage.homeImage, for: .normal)
        eventBtn.setImage(GroupreelImage.eventImage, for: .normal)
        manageBtn.setImage(GroupreelImage.MessageImage, for: .normal)
        settingBtn.setImage(GroupreelImage.SettingImage, for: .normal)
        cameraBtn.setImage(GroupreelImage.cameraImage, for: .normal)
        
        newLabel.textColor = GroupreelColor.blingGreen
    }

}
