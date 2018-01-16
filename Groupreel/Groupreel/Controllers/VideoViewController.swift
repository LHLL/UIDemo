//
//  VideoViewController.swift
//  Groupreel
//
//  Created by Lynn on 11/6/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class VideoViewController: UIViewController {
    @IBOutlet weak var coverView: UIView!
    @IBOutlet weak var whiteBackView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var messageBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var EventBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var segmentController: UISegmentedControl!
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var videoTableView: UITableView!
    @IBOutlet weak var segmentView: UIView!
    
    private var videoes = [Video(name: "Leah Thompson", time: "2 HOUR AGO", thumb: #imageLiteral(resourceName: "thumb1")),
                           Video(name: "Chirag Patel", time: "5 HOUR AGO", thumb: #imageLiteral(resourceName: "thumb3"))]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        videoTableView.register(UINib(nibName: "VideoCell", bundle: nil), forCellReuseIdentifier: "VideoCell")
    }
    
    private func UISetup() {
        navigationController?.title = "23 Videos"
        UINavigationBar.appearance().tintColor = UIColor(displayP3Red: 19/255.0, green: 36/255.0, blue: 58/255.0, alpha: 1)
//        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = UIColor(displayP3Red: 19/255.0, green: 36/255.0, blue: 58/255.0, alpha: 1)
        segmentView.backgroundColor = UIColor(displayP3Red: 19/255.0, green: 36/255.0, blue: 58/255.0, alpha: 1)
        backgroundView.backgroundColor = GroupreelColor.backColor
        
        //tabBarViewImage setup
        cameraBtn.layer.borderWidth = 4
        cameraBtn.layer.borderColor = UIColor.white.cgColor
        cameraBtn.layer.cornerRadius = cameraBtn.frame.size.height / 2
        
        homeBtn.setImage(GroupreelImage.homeImage, for: .normal)
        EventBtn.setImage(GroupreelImage.eventImage, for: .normal)
        messageBtn.setImage(GroupreelImage.MessageImage, for: .normal)
        settingBtn.setImage(GroupreelImage.SettingImage, for: .normal)
        cameraBtn.setImage(GroupreelImage.cameraImage, for: .normal)
    }

    @IBAction func setVideo(_ sender: UIButton) {
        //camera button alert
        coverView.isHidden = false
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let save = UIAlertAction(title: "Save to Photos", style: .default, handler: nil)
        let delete = UIAlertAction(title: "Delete Video", style: .default) { (delete) in
            //delete button alert

            let alertController = UIAlertController(title: "Are you sure you want to delete video?", message: "This action can not be undone", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (cancel) in
                self.coverView.isHidden = true
            })
            let deleteAction = UIAlertAction(title: "Delete", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            alertController.addAction(deleteAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        optionMenu.addAction(save)
        optionMenu.addAction(delete)
        optionMenu.addAction(cancel)
        
        self.present(optionMenu, animated: true, completion: nil)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension VideoViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath)
        if indexPath.section == 0{
            (cell as! VideoCell).nameLabel.text = videoes.first?.name
            (cell as! VideoCell).timeLabel.text = videoes.first?.time
            (cell as! VideoCell).thumbImage.image = videoes.first?.thumb
        }else{
            (cell as! VideoCell).nameLabel.text = videoes.last?.name
            (cell as! VideoCell).timeLabel.text = videoes.last?.time
            (cell as! VideoCell).thumbImage.image = videoes.last?.thumb
        }
        return cell
    }
}

extension VideoViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0{
            return 234
        }else{
            return 234
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0{
            return 20
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v = UIView()
        v.backgroundColor = UIColor(displayP3Red: 46/255.0, green: 66/255.0, blue: 91/255.0, alpha:  0.85)
        return v
    }
}
