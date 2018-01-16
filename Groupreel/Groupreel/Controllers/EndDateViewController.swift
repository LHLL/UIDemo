//
//  EndDateViewController.swift
//  Groupreel
//
//  Created by Lynn on 1/12/18.
//  Copyright © 2018 Lynne. All rights reserved.
//

import UIKit
import JTAppleCalendar

protocol EndDateViewControllerDelegate: class {
    func achieveEndDate(endDate:String, endTime:String)
}

class EndDateViewController: UIViewController {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var cameraBtn: UIButton!
    @IBOutlet weak var settingBtn: UIButton!
    @IBOutlet weak var manageBtn: UIButton!
    @IBOutlet weak var eventBtn: UIButton!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var calendar: JTAppleCalendarView!
    @IBOutlet weak var laterDate: UILabel!
    @IBOutlet weak var pastDate: UILabel!
    @IBOutlet weak var endTimeTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var startTimeTextField: UITextField!
    @IBOutlet weak var startDateTextField: UITextField!
    private var gradientLayer: CAGradientLayer!
    private let formatter = DateFormatter()
    private let current = Date()
    private lazy var datePicker = UIDatePicker()
    private var time:String?
    private var monthStr:String = ""
    private var pastMonthStr:String = ""
    private var laterMonthStr:String = ""
    private var weekStr:String = ""
    private var chosenMonStr:String = ""
    weak var delegate:EndDateViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetup()
        showDatePicker()
        datePickerValue(sender: datePicker)
        
        calendar.calendarDelegate = self
        calendar.calendarDataSource = self
        
        let month = Calendar.current.component(.month, from: current)
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
        currentDate.text = monthStr
        pastDate.text = pastMonthStr
        laterDate.text = laterMonthStr
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

    @IBAction func saveEvent(_ sender: UIButton) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let toEndDate = story.instantiateViewController(withIdentifier: "TVC")
        navigationController?.pushViewController(toEndDate, animated: true)
        delegate?.achieveEndDate(endDate: endDateTextField.text!, endTime: endTimeTextField.text!)
    }
}

extension EndDateViewController:JTAppleCalendarViewDataSource{
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: formatter.string(from: current))!
        let yearToAdd = 1
        let furtureDate = Calendar.current.date(byAdding:.year, value: yearToAdd, to: current)
        let endDate = formatter.date(from: formatter.string(from: furtureDate!))!
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
}

extension EndDateViewController:JTAppleCalendarViewDelegate{
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        cell.endDateLabel.text = cellState.text
        if cellState.isSelected {
            cell.endSelectedView.isHidden = false
        }else{
            cell.endSelectedView.isHidden = true
        }
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CustomCell else { return }
        validCell.endSelectedView.isHidden = false
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
        
        endDateTextField.text = weekStr + " , " + chosenMonStr +  " " + cellState.text
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CustomCell else { return }
        validCell.endSelectedView.isHidden = true
    }
}

extension EndDateViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.text = self.time
        textField.resignFirstResponder()
        return true
    }
}
