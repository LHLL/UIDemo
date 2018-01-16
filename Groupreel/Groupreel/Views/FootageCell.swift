//
//  FootageCell.swift
//  Groupreel
//
//  Created by Lynn on 11/3/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class FootageCell: UITableViewCell {
    @IBOutlet weak var gradientFootage: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var buyBtn: UIButton!
    private var gradientLayer: CAGradientLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        buttonSetup()
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.buyBtn.layer.cornerRadius = buyBtn.frame.size.height / 2
        gradientView.layer.cornerRadius = gradientView.frame.size.height / 2
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.cornerRadius = gradientLayer.frame.size.height / 2
        gradientLayer.colors = [GroupreelColor.gradientStartColor,
                                GroupreelColor.gradientEndColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientView.layer.addSublayer(gradientLayer)
    }
    
    private func buttonSetup() {
        //footage view gradient
        if gradientFootage.layer.sublayers == nil{
            gradientLayer = CAGradientLayer()
            gradientLayer.frame = gradientFootage.bounds
            gradientLayer.colors = [UIColor(red: 111.0/255.0,
                                            green: 195.0/255.0,
                                            blue: 116.0/255.0,
                                            alpha: 1).cgColor,
                                    UIColor(red: 111.0/255.0,
                                            green: 195.0/255.0,
                                            blue: 116.0/255.0,
                                            alpha: 1).cgColor]
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.2)
            gradientFootage.layer.addSublayer(gradientLayer)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
