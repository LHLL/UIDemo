//
//  UpcomingViewController.swift
//  Groupreel
//
//  Created by Lynn on 1/10/18.
//  Copyright © 2018 Lynne. All rights reserved.
//

import UIKit

class UpcomingViewController: UIViewController {
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var manageBtn: UIButton!
    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var backgroundView: UIView!
    private var events =
        [Event(header: "HAPPENING NOW", title: "Ruby's Birthday Bash", startTime: "4:00 PM", endTime: "11:00 PM", startDate: "Wed. Jun 7", endDate: "Wed. Jun 7"),
         Event(header: "STARTS IN 298 DAYS", title: "Leah's Wedding", startTime: "4:00 PM", endTime: "11:00 PM", startDate: "Sat. Oct 27", endDate: "Sat. Oct 27"),
         Event(header: "Intraspire Retreat", title: "Ruby's Birthday Bash", startTime: "4:00 PM", endTime: "11:00 PM", startDate: "Wed. Jun 7", endDate: "Wed. Jun 7")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        eventTableView.register(UINib(nibName: "EventCell", bundle: nil), forCellReuseIdentifier: "EventCell")
    }

    @IBAction func filteTime(_ sender: UISegmentedControl) {
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
    }
}

extension UpcomingViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if segmentController.selectedSegmentIndex == 0 {
            return 2
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        if segmentController.selectedSegmentIndex == 0{
            if indexPath.section == 0{
                (cell as! EventCell).header.text = events.first?.header
                (cell as! EventCell).eventTitle.text = events.first?.title
                (cell as! EventCell).startTime.text = events.first?.startTime
                (cell as! EventCell).endTime.text = events.first?.endTime
                (cell as! EventCell).startDate.text = events.first?.startDate
                (cell as! EventCell).endDate.text = events.first?.endDate
                (cell as! EventCell).header.textColor = GroupreelColor.blingGreen
            }else{
                (cell as! EventCell).header.text = events[indexPath.row + 1].header
                (cell as! EventCell).eventTitle.text = events[indexPath.row + 1].title
                (cell as! EventCell).startTime.text = events[indexPath.row + 1].startTime
                (cell as! EventCell).endTime.text = events[indexPath.row + 1].endTime
                (cell as! EventCell).startDate.text = events[indexPath.row + 1].startDate
                (cell as! EventCell).endDate.text = events[indexPath.row + 1].endDate
                (cell as! EventCell).header.textColor = UIColor.lightGray
            }
        }else{
            (cell as! EventCell).header.text = events.last?.header
            (cell as! EventCell).eventTitle.text = events.last?.title
            (cell as! EventCell).startTime.text = events.last?.startTime
            (cell as! EventCell).endTime.text = events.last?.endTime
            (cell as! EventCell).startDate.text = events.last?.startDate
            (cell as! EventCell).endDate.text = events.last?.endDate
            (cell as! EventCell).header.textColor = UIColor.darkText
        }
        return cell
    }
}

extension UpcomingViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 142
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
}
