//
//  DateViewController.swift
//  Groupreel
//
//  Created by Lynn on 12/11/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit
import JTAppleCalendar

protocol DateViewControllerDelegate: class {
    func achieveStartDate(startDate:String, startTime:String)
}

class DateViewController: UIViewController {
    @IBOutlet weak var laterMonth: UILabel!
    @IBOutlet weak var formerMonth: UILabel!
    @IBOutlet weak var currentMonth: UILabel!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var canlender: JTAppleCalendarView!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var manageBtn: UIButton!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var backgroundView: UIView!
    private var gradientLayer: CAGradientLayer!
    private let formatter = DateFormatter()
    private let currentDate = Date()
    private lazy var datePicker = UIDatePicker()
    private var time:String?
    private var monthStr:String = ""
    private var pastMonthStr:String = ""
    private var laterMonthStr:String = ""
    private var weekStr:String = ""
    private var chosenMonStr:String = ""
    weak var delegate:DateViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        showDatePicker()
        datePickerValue(sender: datePicker)
        
        canlender.calendarDelegate = self
        canlender.calendarDataSource = self
        
        let month = Calendar.current.component(.month, from: currentDate)
        for m in Enumerous.iterateEnum(Month.self){
            if m.rawValue == month{
                monthStr = m.description
            }else if m.rawValue == month - 1{
                pastMonthStr = m.description
            }else if m.rawValue == month + 1{
                laterMonthStr = m.description
            }else if month == 1{
                m.rawValue == 12
                pastMonthStr = m.description
            }
        }
        currentMonth.text = monthStr
        formerMonth.text = pastMonthStr
        laterMonth.text = laterMonthStr
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
        startTimeTextField.inputView = datePicker
        endTimeTextField.inputView = datePicker
    }
    
    private func datePickerValue(sender:UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.none
        self.time = dateFormatter.string(from: sender.date)
    }

    @IBAction func saveDate(_ sender: UIButton) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let toEndDate = story.instantiateViewController(withIdentifier: "TVC")
        navigationController?.pushViewController(toEndDate, animated: true)
        delegate?.achieveStartDate(startDate: startDateTextField.text!, startTime: startTimeTextField.text!)
    }
}

extension DateViewController:JTAppleCalendarViewDataSource{
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale

        let startDate = formatter.date(from: formatter.string(from: currentDate))!
        let yearToAdd = 1
        let furtureDate = Calendar.current.date(byAdding:.year, value: yearToAdd, to: currentDate)
        let endDate = formatter.date(from: formatter.string(from: furtureDate!))!
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
}

extension DateViewController:JTAppleCalendarViewDelegate{
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        cell.dateLabel.text = cellState.text
        if cellState.isSelected {
            cell.selectedView.isHidden = false
        }else{
            cell.selectedView.isHidden = true
        }
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CustomCell else { return }
        validCell.selectedView.isHidden = false
        let week = Calendar.current.component(.weekday, from: cellState.date)
        for w in Enumerous.iterateEnum(Week.self){
            if w.rawValue == week{
                weekStr = w.description
            }
        }
        let chosenMon = Calendar.current.component(.month, from: cellState.date)
        for c in Enumerous.iterateEnum(ChosenMonth.self){
            if c.rawValue == chosenMon{
                chosenMonStr = c.description
            }
        }
        
        startDateTextField.text = weekStr + " , " + chosenMonStr +  " " + cellState.text
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CustomCell else { return }
        validCell.selectedView.isHidden = true
    }
}

extension DateViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.text = self.time
        textField.resignFirstResponder()
        return true
    }
}

