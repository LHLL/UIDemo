//
//  MusicTableViewCell.swift
//  UIDemo
//
//  Created by Xu, Jay on 2/21/17.
//  Copyright © 2017 Wells Fargo. All rights reserved.
//

import UIKit

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var coverImg: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var draftLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateUI(_ movie:Movie?){
        titleLabel.text = movie!.name
        priceLabel.text = movie!.priceTag
        draftLabel.text = movie!.post
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
