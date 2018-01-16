
//
//  VideoCell.swift
//  Groupreel
//
//  Created by Lynn on 11/6/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {
    @IBOutlet weak var videoImage: UIImageView!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImage.layer.cornerRadius = thumbImage.frame.size.height / 2
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
