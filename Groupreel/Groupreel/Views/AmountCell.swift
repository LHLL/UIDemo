//
//  AmountCell.swift
//  Groupreel
//
//  Created by Lynn on 12/7/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit
//protocol AmountCellDelegate:class {
//    func showPrice(price:String)
//}

class AmountCell: UITableViewCell {
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorBottomLine: UIView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var minIncreaseBtn: UIButton!
    @IBOutlet weak var minDecreaseBtn: UIButton!
    @IBOutlet weak var hourLabel: UILabel!
    @IBOutlet weak var hourIncreaseBtn: UIButton!
    @IBOutlet weak var hourDecreaseBtn: UIButton!
    var price:String!
//    weak var delegate:AmountCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        UISetup()
        layer.cornerRadius = 5
    }
    
    private func UISetup() {
        minDecreaseBtn.setImage(IonIcons.image(withIcon: ion_ios_minus_outline, iconColor: GroupreelColor.blingGreen, iconSize: 20, imageSize: CGSize(width: 20, height: 20)), for: .normal)
        hourDecreaseBtn.setImage(IonIcons.image(withIcon: ion_ios_minus_outline, iconColor: GroupreelColor.blingGreen, iconSize: 20, imageSize: CGSize(width: 20, height: 20)), for: .normal)
        minIncreaseBtn.setImage(IonIcons.image(withIcon: ion_ios_plus_outline, iconColor: GroupreelColor.blingGreen, iconSize: 20, imageSize: CGSize(width: 20, height: 20)), for: .normal)
        hourIncreaseBtn.setImage(IonIcons.image(withIcon: ion_ios_plus_outline, iconColor: GroupreelColor.blingGreen, iconSize: 20, imageSize: CGSize(width: 20, height: 20)), for: .normal)
        errorImage.image = GroupreelImage.errorImage
        errorBottomLine.tintColor = GroupreelColor.errorColor
        errorLabel.textColor = GroupreelColor.errorColor
    }
    
    @IBAction func increaseMin(_ sender: UIButton) {
        var min:Int = Int(minLabel.text!)!
        min += 1
        minLabel.text = String(describing: min)
        priceLabel.textColor = GroupreelColor.blingGreen
        priceLabel.text = "$" + String((Int(hourLabel.text!)!*60 + Int(minLabel.text!)!)*2) + ".00"
        self.price = priceLabel.text
    }
    
    @IBAction func decreaseMin(_ sender: UIButton) {
        var min:Int = Int(minLabel.text!)!
        if  Int(minLabel.text!)! >= Int(1){
            min -= 1
            minLabel.text = String(describing: min)
            priceLabel.textColor = GroupreelColor.blingGreen
            priceLabel.text = "$" + String((Int(hourLabel.text!)!*60 + Int(minLabel.text!)!)*2) + ".00"
            self.price = priceLabel.text
        }
        if (priceLabel.text?.contains("$0"))!{
            priceLabel.textColor = UIColor.lightGray
            priceLabel.text = "$0.00"
        }
    }
    
    @IBAction func increaseHour(_ sender: UIButton) {
        var hour:Int = Int(hourLabel.text!)!
        hour += 1
        hourLabel.text = String(describing: hour)
        priceLabel.textColor = GroupreelColor.blingGreen
        priceLabel.text = "$" + String((Int(hourLabel.text!)!*60 + Int(minLabel.text!)!)*2) + ".00"
        self.price = priceLabel.text
    }
    
    @IBAction func decreaseHour(_ sender: UIButton) {
        var hour:Int = Int(hourLabel.text!)!
        if Int(hourLabel.text!)! >= Int(1){
            hour -= 1
            hourLabel.text = String(describing: hour)
            priceLabel.textColor  = GroupreelColor.blingGreen
            priceLabel.text = "$" + String((Int(hourLabel.text!)!*60 + Int(minLabel.text!)!)*2) + ".00"
            self.price = priceLabel.text
        }
        if (priceLabel.text?.contains("$0"))!{
            priceLabel.textColor = UIColor.lightGray
            priceLabel.text = "$0.00"
        }
    }
}

extension AmountCell:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        codeTextField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField.text == ""{
            textField.text = "Enter Promo Code"
        }
        return true
    }
}
