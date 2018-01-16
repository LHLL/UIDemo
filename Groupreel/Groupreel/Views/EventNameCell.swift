//
//  EventNameCell.swift
//  Groupreel
//
//  Created by Lynn on 12/7/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class EventNameCell: UITableViewCell {
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var eventName: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}

extension EventNameCell:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        errorImage.isHidden = true
        errorView.isHidden = true
        eventName.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if eventName.text == ""{
            errorImage.isHidden = false
            errorView.isHidden = false
            errorView.tintColor = GroupreelColor.errorColor
            eventName.text = "Give your event a name."
            eventName.textColor = GroupreelColor.errorColor
        }
        textField.resignFirstResponder()
        return true
    }
}
