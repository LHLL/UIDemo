//
//  SignupViewController.swift
//  Groupreel
//
//  Created by Lynn on 11/30/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var ConfirmCheckImage: UIImageView!
    @IBOutlet weak var PasswordCheckImage: UIImageView!
    @IBOutlet weak var PhoneCheckImage: UIImageView!
    @IBOutlet weak var emailCheckImage: UIImageView!
    @IBOutlet weak var secondCheckImage: UIImageView!
    @IBOutlet weak var firstCheckImage: UIImageView!
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var confirmImage: UIImageView!
    @IBOutlet weak var passwordImage: UIImageView!
    @IBOutlet weak var phoneImage: UIImageView!
    @IBOutlet weak var emailImage: UIImageView!
    @IBOutlet weak var lastNameImage: UIImageView!
    @IBOutlet weak var firstNameImage: UIImageView!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    private var gradientLayer: CAGradientLayer!
    private var checkMark:UIImage?
    private var deleteMark:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()

    }
    
    private func UISetUp() {
        backgroundView.backgroundColor = GroupreelColor.backColor
        signUpBtn.layer.cornerRadius = signUpBtn.frame.size.height / 2
        signInBtn.setTitleColor(UIColor(displayP3Red: 76/25500, green: 197/255.0, blue: 106/255.0, alpha: 1), for: .normal)
        
        deleteMark = IonIcons.image(withIcon: ion_ios_close, iconColor: UIColor.lightGray, iconSize: 18, imageSize: CGSize(width: 18, height: 18))
        checkMark = IonIcons.image(withIcon: ion_checkmark_round, iconColor: UIColor(displayP3Red: 76/25500, green: 197/255.0, blue: 106/255.0, alpha: 1), iconSize: 25, imageSize: CGSize(width: 25, height: 25))
        firstCheckImage.image = checkMark
        secondCheckImage.image = checkMark
        emailCheckImage.image = checkMark
        PhoneCheckImage.image = checkMark
        PasswordCheckImage.image = checkMark
        ConfirmCheckImage.image = checkMark
        
        firstNameImage.image = deleteMark
        lastNameImage.image = deleteMark
        emailImage.image = deleteMark
        phoneImage.image = deleteMark
        passwordImage.image = deleteMark
        confirmImage.image = deleteMark
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = signUpBtn.bounds
        gradientLayer.colors = [GroupreelColor.gradientStartColor,
                                GroupreelColor.gradientEndColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        //        gradientLayer.insertSublayer(signUpBtn.layer, at: 0)
    }

    @IBAction func signIn(_ sender: UIButton) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let toLogin = story.instantiateViewController(withIdentifier: "SIVC")
        navigationController?.pushViewController(toLogin, animated: true)
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let toLogin = story.instantiateViewController(withIdentifier: "SIVC")
        navigationController?.pushViewController(toLogin, animated: true)
    }
}

extension SignupViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == firstNameTextField{
            firstNameImage.isHidden = false
            firstNameTextField.text = ""
            firstCheckImage.isHidden = true
        }else if textField == lastNameTextField{
            lastNameImage.isHidden = false
            lastNameTextField.text = ""
            secondCheckImage.isHidden = true
        }else if textField == emailTextField{
            emailImage.isHidden = false
            emailTextField.text = ""
            emailCheckImage.isHidden = true
        }else if textField == phoneTextField{
            phoneImage.isHidden = false
            phoneTextField.text = ""
            PhoneCheckImage.isHidden = true
        }else if textField == passwordTextField{
            passwordTextField.isSecureTextEntry = true
            passwordImage.isHidden = false
            passwordTextField.text = ""
            PasswordCheckImage.isHidden = true
        }else{
            confirmImage.isHidden = false
            confirmTextField.text = ""
            confirmTextField.isSecureTextEntry = true
            ConfirmCheckImage.isHidden = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField{
            if firstNameTextField.text != ""{
                lastNameTextField.isEnabled = true
                lastNameTextField.becomeFirstResponder()
                firstNameImage.isHidden = true
                firstCheckImage.isHidden = false
            }
        }else if textField == lastNameTextField{
            if lastNameTextField.text != ""{
                emailTextField.isEnabled = true
                emailTextField.becomeFirstResponder()
                lastNameImage.isHidden = true
                secondCheckImage.isHidden = false
//                if lastNameTextField.text == ""{
//                    firstNameTextField.isEnabled = false
//                    emailTextField.isEnabled = false
//                    phoneTextField.isEnabled = false
//                    passwordTextField.isEnabled = false
//                    confirmTextField.isEnabled = false
//                }else{
//                    lastNameTextField.isEnabled = true
//                }
            }
        }else if textField == emailTextField{
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            if emailTest.evaluate(with: textField.text){
                if emailTextField.text != ""{
                    phoneTextField.isEnabled = true
                    phoneTextField.becomeFirstResponder()
                    phoneImage.isHidden = true
                    emailCheckImage.isHidden = false
                    emailImage.isHidden = true
                }
            }else{
                Utility.vibrate()
                emailTextField.text = ""
                return false
            }
        }else if textField == phoneTextField{
            if phoneTextField.text != ""{
                var text = phoneTextField.text
                text!.insert("(", at: text!.startIndex)
                text!.insert(")", at: (text!.index(text!.startIndex, offsetBy: 4)))
                text!.insert(" ", at: (text!.index(text!.startIndex, offsetBy: 5)))
                text!.insert("-", at: (text!.index(text!.startIndex, offsetBy: 9)))
                self.phoneTextField.text = text
               
                passwordTextField.isEnabled = true
                passwordTextField.becomeFirstResponder()
                phoneImage.isHidden = true
                PhoneCheckImage.isHidden = false
            }
        }else if textField == passwordTextField{
            if passwordTextField.text != ""{
                confirmTextField.isEnabled = true
                confirmTextField.becomeFirstResponder()
                passwordImage.isHidden = true
                PasswordCheckImage.isHidden = false
            }
        }else{
            if confirmTextField.text != ""{
                if confirmTextField.text == passwordTextField.text{
                    textField.resignFirstResponder()
                    confirmImage.isHidden = true
                    ConfirmCheckImage.isHidden = false
                }else{
                    Utility.vibrate()
                    confirmTextField.text = ""
                }
            }
        }
        return true
    }
}
