//
//  InfoBoostTableViewCell.swift
//  LivinginsiderTest
//
//  Created by somsak on 16/6/2564 BE.
//

import UIKit

class InfoBoostTableViewCell: UITableViewCell {
    
    static let identifier = "infoBoostTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "InfoBoostTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
