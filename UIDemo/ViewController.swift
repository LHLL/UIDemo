//
//  ViewController.swift
//  UIDemo
//
//  Created by Xu, Jay on 12/2/16.
//  Copyright © 2016 Wells Fargo. All rights reserved.
//

import UIKit

class ViewController: UIViewController, IGLDropDownMenuDelegate {

    @IBOutlet weak var instructionLabel: UILabel!
    
    private var dropDownItems = [IGLDropDownItem]()
    private lazy var dropDownMenu:IGLDropDownMenu = {
        let menu = IGLDropDownMenu()
        menu.menuText = "Start"
        menu.direction = .up
        menu.shouldFlipWhenToggleView = true
        menu.type = .normal
        menu.gutterY = 5
        return menu
    }()
    
    override var prefersStatusBarHidden: Bool {
        return shouldHideStatusBar
    }
    
    private var shouldHideStatusBar: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    private var errors = ["Did'n I tell you to follow instructions? \n" + "Did't I tell you don't click?", "CSI, you deserve this!"]
    
    @IBAction func animate(_ sender: UITapGestureRecognizer) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDropDown()
        instructionLabel.text = "Here are rules you should follow: \n" + "1. Please follow instructions \n" + "2. Please follow instructions \n" + "3. Please follow instructions \n" + "4. Now click on Start Button on the bottom to start"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.isNavigationBarHidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureDropDown(){
        let titles = ["Spotify CollectionView", "Spinner Indicator", "Don't Click", "Segment Control"]
        for title in titles {
            let item = IGLDropDownItem()
            item.text = title
            dropDownItems.append(item)
        }
        dropDownMenu.dropDownItems = dropDownItems
        dropDownMenu.frame = CGRect(x: (view.frame.size.width-200)/2, y: view.frame.size.height-50, width: 200, height: 40)
        dropDownMenu.delegate = self
        dropDownMenu.reloadView()
        view.addSubview(dropDownMenu)
    }
    
    //MARK:IGLDropDownMenuDelegate
    func dropDownMenu(_ dropDownMenu: IGLDropDownMenu!, selectedItemAt index: Int) {
        var destinationVC = UIViewController()
        switch index {
        case 0:
            destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Spotify") as! SpotifyViewController
            navigationController!.pushViewController(destinationVC, animated: true)
        case 1:
            destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Spinner") as! IndicatorViewController
            navigationController!.pushViewController(destinationVC, animated: true)
        case 2:
            throwsErrors()
        case 3:
            destinationVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SliderVC") as! SlideViewController
            navigationController!.pushViewController(destinationVC, animated: true)
        default:
            break
        }
    }
    
    func willExpand(_ dropDownMenu: IGLDropDownMenu!) {
        dropDownMenu.menuButton.setBackgroundViewColor(UIColor.init(colorLiteralRed: 150/255.0, green: 150/255.0 , blue: 150/255.0, alpha: 1))
        dropDownMenu.menuButton.textLabel.text = "Dismiss"
        dropDownMenu.menuButton.textLabel.textColor = UIColor.white
    }
    
    func willCollapse(_ dropDownMenu: IGLDropDownMenu!) {
        dropDownMenu.menuButton.setBackgroundViewColor(UIColor.init(colorLiteralRed: 187/255.0, green: 7/255.0 , blue: 38/255.0, alpha: 1))
        dropDownMenu.menuButton.textLabel.text = "Start"
        dropDownMenu.menuButton.textLabel.textColor = UIColor.init(colorLiteralRed: 244/255.0, green: 187/255.0 , blue: 45/255.0, alpha: 1)
    }
    
    //MARK: Punish Method
    private var botView:UIView = UIView(frame: CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
    private var topView:UIView = UIView(frame: CGRect(x: 0, y: -UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2))
    func throwsErrors() {
        if let error = errors.first {
            let alertVC = UIAlertController(title: "Warning!!!", message: error, preferredStyle: .alert)
            var next:UIAlertAction?
            guard errors.count != 1 else {
                next = UIAlertAction(title: "We will never be slaves!", style: .default) { (reject) in
                    self.shouldHideStatusBar = true
                    self.navigationController?.navigationBar.isHidden = true
                    self.playTrailer()
                }
                alertVC.addAction(next!)
                present(alertVC, animated: true, completion: nil)
                return
            }
            next = UIAlertAction(title: "No, you didn't", style: .default, handler: { (action) in
                self.errors.removeFirst()
                DispatchQueue.main.async {
                    self.throwsErrors()
                }
            })
            let action = UIAlertAction(title: "Regret", style: .cancel, handler: nil)
            alertVC.addAction(action)
            alertVC.addAction(next!)
            DispatchQueue.main.async {
                self.present(alertVC, animated: true, completion: nil)
            }
        }
    }
    
    func playTrailer() {
        
        topView.backgroundColor = UIColor.black
        botView.backgroundColor = UIColor.black
        view.addSubview(topView)
        view.addSubview(botView)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseIn, animations: {
            self.topView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
            self.botView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height/2, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)
        }) { (success) in
            let label = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height/2-11, width: UIScreen.main.bounds.width, height: 21))
            label.text = "GG noob, behave smarter next time!"
            label.textColor = UIColor.white
            self.view.addSubview(label)
            UIView.animate(withDuration: 3, delay: 0, options: .curveEaseIn, animations: {
                label.frame = CGRect(x: UIScreen.main.bounds.width, y: UIScreen.main.bounds.height/2-11, width: UIScreen.main.bounds.width, height: 21)
            }) { (success) in
                let arr = [String]()
                print(arr[1])
            }
        }
    }
    
    
}

