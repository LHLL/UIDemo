//
//  AttendeesCell.swift
//  Groupreel
//
//  Created by Lynn on 11/3/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

protocol AttendeesCellDelegate: class {
    func toInviteController()
}

class AttendeesCell: UITableViewCell {
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var attendeeNumber: UILabel!
    @IBOutlet weak var hostName: UILabel!
    @IBOutlet weak var attendeeImage: UIImageView!
    @IBOutlet weak var hostImage: UIImageView!
    @IBOutlet weak var inviteBtn: UIButton!
    @IBOutlet weak var attendeeView: UIView!
    weak var delegate:AttendeesCellDelegate?
    private var gradientLayer: CAGradientLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.inviteBtn.layer.cornerRadius = inviteBtn.frame.size.height / 2
        gradientView.layer.cornerRadius = gradientView.frame.size.height / 2
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.cornerRadius = gradientView.frame.size.height / 2
        gradientLayer.colors = [GroupreelColor.gradientStartColor,
                                GroupreelColor.gradientEndColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientView.layer.addSublayer(gradientLayer)
    }

    @IBAction func toInvite(_ sender: UIButton) {
        delegate?.toInviteController()
    }
    
}
