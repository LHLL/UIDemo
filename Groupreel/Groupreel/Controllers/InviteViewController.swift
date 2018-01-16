//
//  InviteViewController.swift
//  Groupreel
//
//  Created by Lynn on 11/6/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class InviteViewController: UIViewController {
    @IBOutlet weak var inviteBtn: UIButton!
    @IBOutlet weak var graidentVeiw: UIView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var inviteTableView: UITableView!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var manageBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var segmentView: UIView!
    private var gradientLayer: CAGradientLayer!
    
    private var videos =
        [Video(name: "Leah Thompson", time: "Footage: 1 HOUR 24 MIN", thumb: #imageLiteral(resourceName: "thumb1")),
         Video(name: "Chirag Patel", time: "Footage: 45 MIN", thumb: #imageLiteral(resourceName: "thumb3")),
         Video(name: "Jay Xu", time: "Footage: 1 HOUR 24 MIN", thumb: #imageLiteral(resourceName: "thumb4"))]
    private var phones = [Phone(name: "Alex Daily", phone: "(555)345-5432"),
                          Phone(name: "David Page", phone: "(555)547-3409"),
                          Phone(name: "Kailee Queener", phone: "(555)768-9048")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        inviteTableView.register(UINib(nibName: "InviteCell", bundle: nil), forCellReuseIdentifier: "InviteCell")
    }
    
    override func viewDidLayoutSubviews() {
        //gradient color
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = graidentVeiw.bounds
        gradientLayer.colors = [GroupreelColor.gradientStartColor,
                                GroupreelColor.gradientEndColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        graidentVeiw.layer.addSublayer(gradientLayer)

    }
    
    private func UISetup() {
        navigationController?.title = "Attendees"
        UINavigationBar.appearance().tintColor = UIColor(displayP3Red: 19/255.0, green: 36/255.0, blue: 58/255.0, alpha: 1)
//        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 19/255.0, green: 36/255.0, blue: 58/255.0, alpha: 1)
        segmentView.backgroundColor = UIColor(displayP3Red: 19/255.0, green: 36/255.0, blue: 58/255.0, alpha: 1)
        backgroundView.backgroundColor = GroupreelColor.backColor
//        inviteBtn.layer.cornerRadius = inviteBtn.frame.size.height / 2
        
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

    @IBAction func inviteAttandees(_ sender: UIButton) {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let toInvite = story.instantiateViewController(withIdentifier: "SHVC")
        self.navigationController?.pushViewController(toInvite, animated: true)
    }
}

extension InviteViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if segmentController.selectedSegmentIndex == 0{
            return 2
        }else{
            return 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return videos.count - 1
        }else if section == 1{
            return 1
        }else{
            return self.phones.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        if segmentController.selectedSegmentIndex == 0{
            cell = inviteTableView.dequeueReusableCell(withIdentifier: "InviteCell", for: indexPath)
            if indexPath.section == 0{
                (cell as! InviteCell).nameLabel.text = videos[indexPath.row].name
                (cell as! InviteCell).footageLabel.text = videos[indexPath.row].time
                (cell as! InviteCell).thumbImage.image = videos[indexPath.row].thumb
                (cell as! InviteCell).onlineView.backgroundColor =
                    UIColor(displayP3Red: 133/255.0, green: 207/255.0, blue: 142/255.0, alpha: 1)
            }else{
                (cell as! InviteCell).nameLabel.text = videos.last?.name
                (cell as! InviteCell).footageLabel.text = videos.last?.time
                (cell as! InviteCell).thumbImage.image = videos.last?.thumb
                (cell as! InviteCell).onlineView.layer.borderColor = UIColor.gray.cgColor
                (cell as! InviteCell).onlineView.layer.borderWidth = 2
                (cell as! InviteCell).underlineView.isHidden = true
                return cell!
            }
        }else{
            if indexPath.section == 0{
                (cell as! InviteCell).nameLabel.text = videos[indexPath.row].name
                (cell as! InviteCell).footageLabel.text = videos[indexPath.row].time
                (cell as! InviteCell).thumbImage.image = videos[indexPath.row].thumb
                (cell as! InviteCell).onlineView.isHidden = true
                (cell as! InviteCell).removeBtn.isHidden = false
            }else if indexPath.section == 1{
                (cell as! InviteCell).nameLabel.text = videos.last?.name
                (cell as! InviteCell).footageLabel.text = videos.last?.time
                (cell as! InviteCell).thumbImage.image = videos.last?.thumb
                (cell as! InviteCell).onlineView.isHidden = true
                (cell as! InviteCell).removeBtn.isHidden = false
            }else{
                cell = inviteTableView.dequeueReusableCell(withIdentifier: "PhoneCell", for: indexPath)
                (cell as! PhoneCell).nameLabel.text = phones[indexPath.row].name
                (cell as! PhoneCell).phoneLabel.text = phones[indexPath.row].phone
            }
        }
        return cell!
    }
}

extension InviteViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
