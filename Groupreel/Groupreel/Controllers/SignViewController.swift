//
//  SignViewController.swift
//  Groupreel
//
//  Created by Lynn on 11/29/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class SignViewController: UIViewController {
    @IBOutlet weak var signUpBtn: UIButton!
    @IBOutlet weak var signInBtn: UIButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()

    }
    
    @IBAction func signIn(_ sender: UIButton) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let toSignin = story.instantiateViewController(withIdentifier: "SIVC")
        navigationController?.pushViewController(toSignin, animated: true)
    }
    
    @IBAction func signUp(_ sender: UIButton) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let toSignup = story.instantiateViewController(withIdentifier: "SUVC")
        navigationController?.pushViewController(toSignup, animated: true)
    }
    
    private func UISetup() {
        signInBtn.backgroundColor = UIColor(displayP3Red: 12/25500, green: 52/255.0, blue: 92/255.0, alpha: 1)
        signUpBtn.backgroundColor = UIColor(displayP3Red: 76/25500, green: 197/255.0, blue: 106/255.0, alpha: 1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
