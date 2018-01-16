//
//  MusicCell.swift
//  Groupreel
//
//  Created by Lynn on 12/7/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit

class MusicCell: UITableViewCell {
    @IBOutlet weak var errorImage: UIImageView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var musicTextField: UITextField!
    private lazy var musicPicker = UIPickerView()
    private var pickerData = ["Acoustic", "Dance", "Dubstep", "Electronica", "Happy Rock", "Soft Jazz", "Upbeat Jazz"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
        //UIPickerView
        self.musicPicker.delegate = self
        self.musicPicker.dataSource = self
        picker()
        musicTextField.inputView = self.musicPicker
    }
    
    private func picker() {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.tintColor = UIColor.lightGray
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(dismissPickerView))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
//        doneButton.accessibilityFrame = CGRect(x: 0, y: 0, width: 200, height: 44)
        doneButton.tintColor = UIColor.blue
        
        toolBar.setItems([spaceButton,doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        musicTextField.inputAccessoryView = toolBar
    }
    
    @objc private func dismissPickerView(){
        musicTextField.resignFirstResponder()
    }
    
}

extension MusicCell:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        musicTextField.text = ""
        errorImage.isHidden = true
        errorView.isHidden = true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        musicTextField.text = pickerData[musicPicker.selectedRow(inComponent: 0)]
        if musicTextField.text == ""{
            errorImage.isHidden = false
            errorView.isHidden = false
            errorView.tintColor = GroupreelColor.errorColor
            musicTextField.text = "Choose a genre of music for your final video."
            musicTextField.textColor = GroupreelColor.errorColor
        }
    }
}

extension MusicCell:UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
