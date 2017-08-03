//
//  CardDetailCollectionViewCell.swift
//  UIDemo
//
//  Created by Xu, Jay on 1/25/17.
//  Copyright © 2017 Wells Fargo. All rights reserved.
//

import UIKit

class CardDetailCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cardDetails: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension CardDetailCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cardCell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cardCell")
        }
        cell!.textLabel?.text = "\(indexPath.row)"
        return cell!
    }
}
