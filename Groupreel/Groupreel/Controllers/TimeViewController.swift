//
//  TimeViewController.swift
//  Groupreel
//
//  Created by Lynn on 12/26/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class TimeViewController: UIViewController {
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var endTimePicker: UITextField!
    @IBOutlet weak var endDatePicker: UITextField!
    @IBOutlet weak var startTimePicker: UITextField!
    @IBOutlet weak var startDatePicker: UITextField!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var manageBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    private var gradientLayer: CAGradientLayer!
    private lazy var datePicker = UIDatePicker()
    private var time:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        showDatePicker()
        datePickerValue(sender: datePicker)
        DateViewController().delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        //gradient color
        gradientLayer = CAGradientLayer()
        gradientView.layer.cornerRadius = gradientView.frame.size.height / 2
        gradientLayer.frame = gradientView.bounds
        gradientLayer.colors = [GroupreelColor.gradientStartColor,
                                GroupreelColor.gradientEndColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientView.layer.addSublayer(gradientLayer)
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
    
    private func showDatePicker(){
        datePicker.datePickerMode = .time
        datePicker.minuteInterval = 5
        startTimePicker.inputView = datePicker
        endTimePicker.inputView = datePicker
    }
    
    private func datePickerValue(sender:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        self.time = dateFormatter.string(from: sender.date)
    }
}

extension TimeViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
        if textField == startDatePicker {
            let story = UIStoryboard(name: "Main", bundle: nil)
            let toPickTime = story.instantiateViewController(withIdentifier: "DVC")
            navigationController?.pushViewController(toPickTime, animated: true)
        }else if textField == endDatePicker{
            let story = UIStoryboard(name: "Main", bundle: nil)
            let pickEndTime = story.instantiateViewController(withIdentifier: "EDVC")
            navigationController?.pushViewController(pickEndTime, animated: true)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == startTimePicker || textField == endTimePicker{
            textField.text = self.time
        }
        textField.resignFirstResponder()
        return true
    }
}

extension TimeViewController:DateViewControllerDelegate{
    func achieveStartDate(startDate: String, startTime: String) {
        self.startDatePicker.text = startDate
        self.startTimePicker.text = startTime
    }
}

extension TimeViewController:EndDateViewControllerDelegate{
    func achieveEndDate(endDate: String, endTime: String) {
        self.endDatePicker.text = endDate
        self.endTimePicker.text = endTime
    }
}
