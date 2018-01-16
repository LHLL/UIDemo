//
//  ShareViewController.swift
//  Groupreel
//
//  Created by Lynn on 11/14/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {
    @IBOutlet weak var codeBtn: UIButton!
    @IBOutlet weak var usernameBtn: UIButton!
    @IBOutlet weak var contactBtn: UIButton!
    @IBOutlet weak var codeBackImage: UIImageView!
    @IBOutlet weak var usernameBackImage: UIImageView!
    @IBOutlet weak var contactBackImage: UIImageView!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var manageBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var addTableView: UITableView!
    
    private var videos =
        [Video(name: "Leah Thompson", time: "leahrhene", thumb: #imageLiteral(resourceName: "thumb1")),
         Video(name: "Chirag Patel", time: "chiragpatel", thumb: #imageLiteral(resourceName: "thumb3")),
         Video(name: "Jay Xu", time: "jayxu", thumb: #imageLiteral(resourceName: "thumb4"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTableView.register(UINib(nibName: "AddCell", bundle: nil), forCellReuseIdentifier: "AddCell")
        UISetup()
    }
    
    private func UISetup() {
        backgroundView.backgroundColor = GroupreelColor.backColor
        
        //tabBarViewImage setup
        cameraBtn.layer.borderWidth = 4
        cameraBtn.layer.borderColor = UIColor.white.cgColor
        cameraBtn.layer.cornerRadius = cameraBtn.frame.size.height / 2
        
        homeBtn.setImage(GroupreelImage.homeImage, for: .normal)
        eventBtn.setImage(GroupreelImage.eventImage, for: .normal)
        manageBtn.setImage(GroupreelImage.MessageImage, for: .normal)
        settingBtn.setImage(GroupreelImage.SettingImage, for: .normal)
        cameraBtn.setImage(GroupreelImage.cameraImage, for: .normal)
        
        contactBackImage.image = IonIcons.image(withIcon: ion_chevron_right, iconColor: UIColor.lightGray, iconSize: 15, imageSize: CGSize(width: 15, height: 15))
        usernameBackImage.image = IonIcons.image(withIcon: ion_chevron_right, iconColor: UIColor.lightGray, iconSize: 15, imageSize: CGSize(width: 15, height: 15))
        codeBackImage.image = IonIcons.image(withIcon: ion_chevron_right, iconColor: UIColor.lightGray, iconSize: 15, imageSize: CGSize(width: 15, height: 15))
    }
    
    @IBAction func inviteCode(_ sender: UIButton) {
        
    }
    
    @IBAction func inviteContacts(_ sender: UIButton) {
        let alert = UIAlertController(title: "GroupReel Would Like to Access Your Contacts", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Don't Allow", style: .cancel, handler: nil)
        let ok = UIAlertAction(title: "OK", style: .default) { (done) in
            let story = UIStoryboard(name: "Main", bundle: nil)
            let toContact = story.instantiateViewController(withIdentifier: "CVC")
            self.navigationController?.pushViewController(toContact, animated: true)
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func inviteUsername(_ sender: UIButton) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let toSearch = story.instantiateViewController(withIdentifier: "SVC")
        self.navigationController?.pushViewController(toSearch, animated: true)
    }
}

extension ShareViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return videos.count - 1
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = addTableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath)
        if indexPath.section == 0{
            (cell as! AddCell).nameLabel.text = videos[indexPath.row].name
            (cell as! AddCell).nicknameLabel.text = videos[indexPath.row].time
            (cell as! AddCell).thumbImage.image = videos[indexPath.row].thumb
            (cell as! AddCell).addBtn.isEnabled = false
        }else{
            (cell as! AddCell).nameLabel.text = videos.last?.name
            (cell as! AddCell).nicknameLabel.text = videos.last?.time
            (cell as! AddCell).thumbImage.image = videos.last?.thumb
            (cell as! AddCell).bottomView.isHidden = true
            (cell as! AddCell).addBtn.isEnabled = false
        }
        return cell
    }
}

extension ShareViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
