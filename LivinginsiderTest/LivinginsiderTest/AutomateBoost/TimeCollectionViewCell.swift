//
//  TimeCollectionViewCell.swift
//  LivinginsiderTest
//
//  Created by somsak on 17/6/2564 BE.
//

import UIKit

class TimeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var timeLabel: UILabel!
    
    static let identifier = "timeCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TimeCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
