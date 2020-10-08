//
//  LikeTableViewCell.swift
//  iOSRestaurant
//
//  Created by 許自翔 on 2020/10/7.
//

import UIKit

class LikeTableViewCell: UITableViewCell {

    @IBOutlet weak var lbName: UILabel!
    @IBOutlet weak var lbPhone: UILabel!
    @IBOutlet weak var lbCity: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
