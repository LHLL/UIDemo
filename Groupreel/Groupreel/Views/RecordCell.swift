//
//  RecordCell.swift
//  Groupreel
//
//  Created by Lynn on 11/7/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

protocol RecordCellDelegate: class {
    func todisplayVideos()
}

class RecordCell: UITableViewCell {
    @IBOutlet weak var numberView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var thirdImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var firstImage: UIImageView!
    weak var delegate:RecordCellDelegate?
    private var gradientLayer: CAGradientLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [GroupreelColor.gradientStartColor,
                                GroupreelColor.gradientEndColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientView.layer.addSublayer(gradientLayer)
    }
    
    @IBAction func displayVideos(_ sender: UIButton) {
        delegate?.todisplayVideos()
    }
}
