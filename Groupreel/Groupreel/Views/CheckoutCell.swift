//
//  CheckoutCell.swift
//  Groupreel
//
//  Created by Lynn on 12/11/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit
protocol CheckoutCellDelegate:class {
    func toPayment()
}

class CheckoutCell: UITableViewCell {
    @IBOutlet weak var checkoutBtn: UIButton!
    @IBOutlet weak var gradientView: UIView!
    private var gradientLayer: CAGradientLayer!
    weak var delegate:CheckoutCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkoutBtn.layer.cornerRadius = checkoutBtn.frame.size.height / 2
        checkoutBtn.layer.masksToBounds = true
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        gradientView.layer.cornerRadius = gradientView.frame.size.height / 2
        gradientView.layer.masksToBounds = true
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [GroupreelColor.gradientStartColor,
                                GroupreelColor.gradientEndColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientView.layer.addSublayer(gradientLayer)
    }

    @IBAction func checkout(_ sender: UIButton) {
        delegate?.toPayment()
    }
    
}
