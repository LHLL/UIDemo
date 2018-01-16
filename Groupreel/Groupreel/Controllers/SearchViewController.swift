//
//  SearchViewController.swift
//  Groupreel
//
//  Created by Lynn on 11/18/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var speechImage: UIImageView!
    @IBOutlet weak var lensImage: UIImageView!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var manageBtn: UIButton!
    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    
    private var videos = [Video(name: "Leah Thompson", time: "leahrhene", thumb: #imageLiteral(resourceName: "thumb1"))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.register(UINib(nibName: "AddCell", bundle: nil), forCellReuseIdentifier: "AddCell")
        UISetup()
    }

    private func UISetup() {
        backgroundView.backgroundColor = GroupreelColor.backColor
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

extension SearchViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddCell", for: indexPath)
        (cell as! AddCell).nameLabel.text = videos[indexPath.row].name
        (cell as! AddCell).nicknameLabel.text = videos[indexPath.row].time
        (cell as! AddCell).thumbImage.image = videos[indexPath.row].thumb
        (cell as! AddCell).bottomView.isHidden = true
        return cell
    }
}

extension SearchViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

extension SearchViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        lensImage.isHidden = true
        speechImage.isHidden = true
        searchTextField.text = ""
        searchTableView.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if searchTextField.text?.contains("e") == true{
            textField.resignFirstResponder()
            searchTableView.isHidden = false
        }
        return true
    }
}


