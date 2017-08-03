//
//  CardCollectionViewCell.swift
//  UIDemo
//
//  Created by Xu, Jay on 1/23/17.
//  Copyright © 2017 Wells Fargo. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        transform = .identity
    }
}
