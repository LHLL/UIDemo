//
//  EventCell.swift
//  Groupreel
//
//  Created by Lynn on 1/10/18.
//  Copyright © 2018 Lynne. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var eventTitle: UILabel!
    @IBOutlet weak var header: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
