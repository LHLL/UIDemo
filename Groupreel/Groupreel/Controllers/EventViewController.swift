//
//  EventViewController.swift
//  Groupreel
//
//  Created by Lynn on 12/7/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class EventViewController: UIViewController {
    
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var manageBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
//    var price:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        registerCell()

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
    
    private func registerCell() {
        eventTableView.register( UINib(nibName: "EventNameCell", bundle: nil), forCellReuseIdentifier: "EventNameCell")
        eventTableView.register( UINib(nibName: "ScheduleCell", bundle: nil), forCellReuseIdentifier: "ScheduleCell")
        eventTableView.register( UINib(nibName: "AmountCell", bundle: nil), forCellReuseIdentifier: "AmountCell")
        eventTableView.register( UINib(nibName: "MusicCell", bundle: nil), forCellReuseIdentifier: "MusicCell")
        eventTableView.register( UINib(nibName: "NoteCell", bundle: nil), forCellReuseIdentifier: "NoteCell")
        eventTableView.register( UINib(nibName: "CheckoutCell", bundle: nil), forCellReuseIdentifier: "CheckoutCell")
    }
    
    @IBAction func checkOut(_ sender: UIButton) {
        
    }
}

extension EventViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        if indexPath.section == 0{
            cell = tableView.dequeueReusableCell(withIdentifier: "EventNameCell", for: indexPath)
        }else if indexPath.section == 1{
            cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleCell", for: indexPath)
            (cell as! ScheduleCell).delegate = self
        }else if indexPath.section == 2{
            cell = tableView.dequeueReusableCell(withIdentifier: "AmountCell", for: indexPath)
//            (cell as! AmountCell).priceLabel.text = self.price
        }else if indexPath.section == 3{
            cell = tableView.dequeueReusableCell(withIdentifier: "MusicCell", for: indexPath)
        }else if indexPath.section == 4{
            cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath)
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "CheckoutCell", for: indexPath)
            (cell as! CheckoutCell).delegate = self
        }
        return cell!
    }
}

extension EventViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 111
        }else if indexPath.section == 1{
            return 125
        }else if indexPath.section == 2{
            return 228
        }else if indexPath.section == 3{
            return 109
        }else if indexPath.section == 4{
            return 109
        }else{
            return 64
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

extension EventViewController:CheckoutCellDelegate{
    func toPayment() {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let toPay = story.instantiateViewController(withIdentifier: "PVC")
        navigationController?.pushViewController(toPay, animated: true)
    }
}

extension EventViewController:ScheduleCellDelegate{
    func chooseDate() {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let toDate = story.instantiateViewController(withIdentifier: "TVC")
        navigationController?.pushViewController(toDate, animated: true)
    }
}
