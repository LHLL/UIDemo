//
//  PhoneCell.swift
//  Groupreel
//
//  Created by Lynn on 11/14/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class PhoneCell: UITableViewCell {
    @IBOutlet weak var chooseImage: UIImageView!
    @IBOutlet weak var inviteBtn: UIButton!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var removeBtn: UIButton!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UISetup()
    }

    private func UISetup() {
        removeBtn.layer.cornerRadius = removeBtn.frame.size.height / 2
        removeBtn.layer.borderWidth = 2
        removeBtn.layer.borderColor = UIColor.lightGray.cgColor
        inviteBtn.layer.cornerRadius = inviteBtn.frame.size.height / 2
        inviteBtn.layer.borderWidth = 2
        inviteBtn.layer.borderColor = UIColor(displayP3Red: 107/255.0, green: 209/255.0, blue: 135/255.0, alpha: 1).cgColor
        inviteBtn.setTitleColor(UIColor(displayP3Red: 107/255.0, green: 209/255.0, blue: 135/255.0, alpha: 1), for: .normal)
        chooseImage.backgroundColor = UIColor(displayP3Red: 107/255.0, green: 209/255.0, blue: 135/255.0, alpha: 1)
        chooseImage.layer.cornerRadius = chooseImage.frame.size.height / 2
        chooseImage.image = IonIcons.image(withIcon: ion_ios_checkmark_empty, iconColor: .white, iconSize: 12, imageSize:CGSize(width: 12, height: 12))
    }
        
    @IBAction func inviteContacts(_ sender: UIButton) {
        inviteBtn.isHidden = true
        chooseImage.isHidden = false
    }
    
}
