//
//  PaymentViewController.swift
//  Groupreel
//
//  Created by Lynn on 12/11/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class PaymentViewController: UIViewController {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var paymentBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var manageBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    private var gradientLayer: CAGradientLayer!
//    var receivePrice:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        backView.layer.cornerRadius = 5
        
    }
    
    override func viewDidLayoutSubviews() {
        //gradient color
        paymentBtn.layer.cornerRadius = paymentBtn.frame.size.height / 2
        gradientView.layer.cornerRadius = gradientView.frame.size.height / 2
        gradientView.layer.masksToBounds = true
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [GroupreelColor.gradientStartColor,
                                GroupreelColor.gradientEndColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientView.layer.addSublayer(gradientLayer)
    }

    private func UISetup() {
        backgroundView.backgroundColor = GroupreelColor.backColor
        totalLabel.textColor = GroupreelColor.blingGreen
        
        //tabBarViewImage setup
        cameraBtn.layer.borderWidth = 4
        cameraBtn.layer.borderColor = UIColor.white.cgColor
        cameraBtn.layer.cornerRadius = cameraBtn.frame.size.height / 2
        
        homeBtn.setImage(GroupreelImage.homeImage, for: .normal)
        eventBtn.setImage(GroupreelImage.eventImage, for: .normal)
        manageBtn.setImage(GroupreelImage.MessageImage, for: .normal)
        settingBtn.setImage(GroupreelImage.SettingImage, for: .normal)
        cameraBtn.setImage(GroupreelImage.cameraImage, for: .normal)
    }

}

extension PaymentViewController:UITextFieldDelegate{
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

//extension PaymentViewController:AmountCellDelegate{
//    func showPrice(price: String) {
//        priceLabel.text = price
//    }
//}

