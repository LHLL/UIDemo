//
//  myCollectionViewCell.swift
//  UIDemo
//
//  Created by Xu, Jay on 12/2/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        containerView.layer.cornerRadius = 15
        containerView.isUserInteractionEnabled = true
    }
    
}
