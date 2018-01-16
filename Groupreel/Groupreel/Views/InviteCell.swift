//
//  InviteCell.swift
//  Groupreel
//
//  Created by Lynn on 11/7/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class InviteCell: UITableViewCell {
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var underlineView: UIView!
    @IBOutlet weak var onlineView: UIView!
    @IBOutlet weak var footageLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        onlineView.layer.cornerRadius = onlineView.frame.size.height / 2
        removeBtn.layer.cornerRadius = removeBtn.frame.size.height / 2
        removeBtn.layer.borderWidth = 2
        removeBtn.layer.borderColor = UIColor.lightGray.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
