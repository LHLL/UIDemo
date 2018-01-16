//
//  SigninViewController.swift
//  Groupreel
//
//  Created by Lynn on 11/30/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var passwordImage: UIImageView!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var signBtn: UIButton!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    private var gradientLayer: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
    }
    
    private func UISetup() {
        backgroundView.backgroundColor = GroupreelColor.backColor
        
        signBtn.layer.cornerRadius = signBtn.frame.size.height / 2
        signUpBtn.setTitleColor(UIColor(displayP3Red: 76/25500, green: 197/255.0, blue: 106/255.0, alpha: 1), for: .normal)
        
        passwordImage.layer.cornerRadius = passwordImage.frame.size.height / 2
        emailImage.layer.cornerRadius = emailImage.frame.size.height / 2
        passwordImage.image = IonIcons.image(withIcon: ion_ios_close, iconColor: UIColor.lightGray, iconSize: 18, imageSize: CGSize(width: 18, height: 18))
        emailImage.image = IonIcons.image(withIcon: ion_ios_close, iconColor: UIColor.lightGray, iconSize: 18, imageSize: CGSize(width: 18, height: 18))
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = signBtn.bounds
        gradientLayer.colors = [GroupreelColor.gradientStartColor,
                                GroupreelColor.gradientEndColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
//        gradientLayer.insertSublayer(signBtn.layer, at: 0)
    }

    @IBAction func signUp(_ sender: UIButton) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let toSignUp = story.instantiateViewController(withIdentifier: "SUVC")
        navigationController?.pushViewController(toSignUp, animated: true)
    }
    
    @IBAction func signIn(_ sender: UIButton) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let toBashController = story.instantiateViewController(withIdentifier: "BVC")
        navigationController?.pushViewController(toBashController, animated: true)
    }
}

extension SigninViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == emailTextField{
            emailImage.isHidden = false
            emailTextField.text = ""
        }else{
            passwordTextField.isSecureTextEntry = true
            passwordImage.isHidden = false
            passwordTextField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField{
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            if emailTest.evaluate(with: textField.text){
                passwordTextField.becomeFirstResponder()
            }else{
                Utility.vibrate()
                emailTextField.text = ""
                return false
            }
            if emailTextField.text != ""{
                passwordTextField.isEnabled = true
            }
        }else{
            textField.resignFirstResponder()
        }
        return true
    }
}

