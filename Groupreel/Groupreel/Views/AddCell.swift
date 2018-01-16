//
//  AddCell.swift
//  Groupreel
//
//  Created by Lynn on 11/17/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class AddCell: UITableViewCell {
    @IBOutlet weak var chooseImage: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var thumbImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addBtn.layer.cornerRadius = addBtn.frame.size.height / 2
        addBtn.layer.borderWidth = 2
        addBtn.layer.borderColor = UIColor(displayP3Red: 107/255.0, green: 209/255.0, blue: 135/255.0, alpha: 1).cgColor
        addBtn.setTitleColor(UIColor(displayP3Red: 107/255.0, green: 209/255.0, blue: 135/255.0, alpha: 1), for: .normal)
        chooseImage.backgroundColor = UIColor(displayP3Red: 107/255.0, green: 209/255.0, blue: 135/255.0, alpha: 1)
        chooseImage.layer.cornerRadius = chooseImage.frame.size.height / 2
        chooseImage.image = IonIcons.image(withIcon: ion_ios_checkmark_empty, iconColor: .white, iconSize: 12, imageSize:CGSize(width: 12, height: 12))
    }

    @IBAction func addUsers(_ sender: UIButton) {
        addBtn.isHidden = true
        chooseImage.isHidden = false
    }

}
