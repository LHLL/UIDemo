//
//  ContactsViewController.swift
//  Groupreel
//
//  Created by Lynn on 11/18/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var speechImage: UIImageView!
    @IBOutlet weak var lensImage: UIImageView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var manageBtn: UIButton!
    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var userTableView: UITableView!
    private var videos =
        [Video(name: "Leah Thompson", time: "leahrhene", thumb: #imageLiteral(resourceName: "thumb1")),
         Video(name: "Chirag Patel", time: "chiragpatel", thumb: #imageLiteral(resourceName: "thumb3")),
         Video(name: "Jay Xu", time: "jayxu", thumb: #imageLiteral(resourceName: "thumb4"))]
    private var phones = [Phone(name: "Alex Daily", phone: "(555)345-5432"),
                          Phone(name: "David Page", phone: "(555)547-3409"),
                          Phone(name: "Kailee Queener", phone: "(555)768-9048")]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UISetup()
    }

    private func UISetup() {
        backgroundView.backgroundColor = GroupreelColor.backColor
        userTableView.register(UINib(nibName: "AddCell", bundle: nil), forCellReuseIdentifier: "AddCell")
        userTableView.register(UINib(nibName: "PhoneCell", bundle: nil), forCellReuseIdentifier: "PhoneCell")
        topView.backgroundColor =  UIColor(displayP3Red: 19/255.0, green: 36/255.0, blue: 58/255.0, alpha: 1)
        
        //tabBarViewImage setup
        cameraBtn.layer.borderWidth = 4
        cameraBtn.layer.borderColor = UIColor.white.cgColor
        cameraBtn.layer.cornerRadius = cameraBtn.frame.size.height / 2
        
        homeBtn.setImage(GroupreelImage.homeImage, for: .normal)
        eventBtn.setImage(GroupreelImage.eventImage, for: .normal)
        manageBtn.setImage(GroupreelImage.MessageImage, for: .normal)
        settingBtn.setImage(GroupreelImage.SettingImage, for: .normal)
        cameraBtn.setImage(GroupreelImage.cameraImage, for: .normal)
        
        topView.backgroundColor = UIColor(displayP3Red: 19/255.0, green: 36/255.0, blue: 58/255.0, alpha: 1)
        
        lensImage.image = IonIcons.image(withIcon: ion_ios_search_strong, iconColor: UIColor.lightText, iconSize: 18, imageSize: CGSize(width: 18, height: 18))
        speechImage.image = IonIcons.image(withIcon: ion_mic_a, iconColor: UIColor.lightText, iconSize: 18, imageSize: CGSize(width: 18, height: 18))
        
        searchTextField.layer.cornerRadius = 8
        searchTextField.backgroundColor = UIColor(displayP3Red: 30/255.0, green: 50/255.0, blue: 71/255.0, alpha: 1)
    }
}

extension ContactsViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            title = "GROUPREEL USERS"
        }else if section == 2{
            title = "FROM CONTACTS"
        }else{
            title = nil
        }
        return title
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return videos.count - 1
        }else if section == 2{
            return phones.count - 1
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        if indexPath.section == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath)
            (cell as! AddCell).nameLabel.text = videos[indexPath.row].name
            (cell as! AddCell).nicknameLabel.text = videos[indexPath.row].time
            (cell as! AddCell).thumbImage.image = videos[indexPath.row].thumb
        }else if indexPath.section == 1{
            cell = tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath)
            (cell as! AddCell).nameLabel.text = videos.last?.name
            (cell as! AddCell).nicknameLabel.text = videos.last?.time
            (cell as! AddCell).thumbImage.image = videos.last?.thumb
            (cell as! AddCell).bottomView.isHidden = true
        }else if indexPath.section == 2{
            cell = tableView.dequeueReusableCell(withIdentifier: "PhoneCell", for: indexPath)
            (cell as! PhoneCell).removeBtn.isHidden = true
            (cell as! PhoneCell).inviteBtn.isHidden = false
            (cell as! PhoneCell).nameLabel.text = phones[indexPath.row].name
            (cell as! PhoneCell).phoneLabel.text = phones[indexPath.row].phone
        }else{
             cell = tableView.dequeueReusableCell(withIdentifier: "PhoneCell", for: indexPath)
            (cell as! PhoneCell).removeBtn.isHidden = true
            (cell as! PhoneCell).inviteBtn.isHidden = false
            (cell as! PhoneCell).nameLabel.text = phones.last?.name
            (cell as! PhoneCell).phoneLabel.text = phones.last?.phone
            (cell as! PhoneCell).bottomView.isHidden = true
        }
        return cell!
    }
}

extension ContactsViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 30
        }else if section == 2{
            return 30
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension ContactsViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lensImage.isHidden = true
        speechImage.isHidden = true
        searchTextField.text = ""
    }
}


