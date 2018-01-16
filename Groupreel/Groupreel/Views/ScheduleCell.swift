//
//  ScheduleCell.swift
//  Groupreel
//
//  Created by Lynn on 12/7/17.
//  Copyright © 2017 Lynne. All rights reserved.
//

import UIKit
protocol ScheduleCellDelegate:class {
    func chooseDate()
}

class ScheduleCell: UITableViewCell {
    @IBOutlet weak var endView: UIView!
    @IBOutlet weak var endLabel: UILabel!
    @IBOutlet weak var startView: UIView!
    @IBOutlet weak var startLabel: UILabel!
    weak var delegate:ScheduleCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
        let tap = UITapGestureRecognizer(target: self, action: #selector(chooseDate))
        startView.addGestureRecognizer(tap)
    }
    
    @objc func chooseDate() {
        delegate?.chooseDate()
    }
    
}
