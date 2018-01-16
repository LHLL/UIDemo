//
//  NoteCell.swift
//  Groupreel
//
//  Created by Lynn on 12/7/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class NoteCell: UITableViewCell {
    @IBOutlet weak var noteTextField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension NoteCell:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        noteTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
