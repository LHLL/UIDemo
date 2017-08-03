//
//  MovieCollectionViewCell.swift
//  UIDemo
//
//  Created by Xu, Jay on 2/21/17.
//  Copyright © 2017 Wells Fargo. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cover: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
    }
    
    func configureUI(movie:Movie){
        titleLabel.text = movie.name
        priceLabel.text = movie.priceTag
    }
}
