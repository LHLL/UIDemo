//
//  BashViewController.swift
//  Groupreel
//
//  Created by Lynn on 11/3/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class BashViewController: UIViewController {
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var bashTableView: UITableView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var fourthPageBtn: UIButton!
    @IBOutlet weak var thirdPageBtn: UIButton!
    @IBOutlet weak var secondPageBtn: UIButton!
    @IBOutlet weak var firstPageBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
        UISetup()
    }
    
    private func UISetup() {
        //navigationController Setup
        UINavigationBar.appearance().barTintColor = UIColor(displayP3Red: 19/255.0, green: 36/255.0, blue: 58/255.0, alpha: 1)
        navigationController?.title = "Ruby's Birthday Bash"
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 19/255.0, green: 36/255.0, blue: 58/255.0, alpha: 1)
        navigationItem.leftBarButtonItem?.image = IonIcons.image(withIcon: ion_chevron_left, iconColor: UIColor.white, iconSize: 30, imageSize: CGSize(width: 30, height: 30))
        
        backgroundView.backgroundColor = GroupreelColor.backColor
        
        //tabBarViewImage setup 
        cameraBtn.layer.borderWidth = 4
        cameraBtn.layer.borderColor = UIColor.white.cgColor
        cameraBtn.layer.cornerRadius = cameraBtn.frame.size.height / 2
        
        firstPageBtn.setImage(GroupreelImage.homeImage, for: .normal)
        secondPageBtn.setImage(GroupreelImage.eventImage, for: .normal)
        thirdPageBtn.setImage(GroupreelImage.MessageImage, for: .normal)
        fourthPageBtn.setImage(GroupreelImage.SettingImage, for: .normal)
        cameraBtn.setImage(GroupreelImage.cameraImage, for: .normal)
    }
    
    private func registerCell() {
        bashTableView.register(UINib(nibName: "AttendeesCell", bundle: nil), forCellReuseIdentifier: "AttendeesCell")
        bashTableView.register(UINib(nibName: "TimeCell", bundle: nil), forCellReuseIdentifier: "TimeCell")
        bashTableView.register(UINib(nibName: "FootageCell", bundle: nil), forCellReuseIdentifier: "FootageCell")
        bashTableView.register(UINib(nibName: "RecordCell", bundle: nil), forCellReuseIdentifier: "RecordCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BashViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AttendeesCell", for: indexPath)
            cell.backgroundColor = UIColor.clear
            (cell as! AttendeesCell).hostImage.image = UIImage.init(named: "thumb1")
            (cell as! AttendeesCell).attendeeImage.image = UIImage.init(named: "thumb2")
            (cell as! AttendeesCell).delegate = self
            return cell
        }else if indexPath.section == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TimeCell", for: indexPath)
            return cell
        }else if indexPath.section == 2{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FootageCell", for: indexPath)
            cell.backgroundColor = UIColor.clear
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "RecordCell", for: indexPath)
            (cell as! RecordCell).firstImage.image = UIImage.init(named: "Record1")
            (cell as! RecordCell).secondImage.image = UIImage.init(named: "Record2")
            (cell as! RecordCell).thirdImage.image = UIImage.init(named: "Record3")
            (cell as! RecordCell).delegate = self
            return cell
        }
    }
}

extension BashViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 168
        }else if indexPath.section == 1{
            return 129
        }else if indexPath.section == 2{
            return 220
        }else{
            return 163
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 1 {
            return 30
        }else{
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
}

extension BashViewController:RecordCellDelegate{
    func todisplayVideos() {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let toVideo = story.instantiateViewController(withIdentifier: "VVC")
        self.navigationController?.pushViewController(toVideo, animated: true)
    }
}

extension BashViewController:AttendeesCellDelegate{
    func toInviteController() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let toInvite = storyBoard.instantiateViewController(withIdentifier: "IVC")
        self.navigationController?.pushViewController(toInvite, animated: true)
    }
}

