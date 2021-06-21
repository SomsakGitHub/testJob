//
//  IndicatorCell.swift
//  pantipTest
//
//  Created by somsak on 14/6/2564 BE.
//

import UIKit

class IndicatorCell: UITableViewCell {
    
    static let identifier = "indicatorCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "IndicatorCell", bundle: nil)
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
