//
//  SaveTableViewCell.swift
//  LivinginsiderTest
//
//  Created by somsak on 17/6/2564 BE.
//

import UIKit

class SaveTableViewCell: UITableViewCell {
    
    static let identifier = "saveTableViewCell"
    
    var selectNext: (() -> Void) = {}
    
    static func nib() -> UINib {
        return UINib(nibName: "SaveTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func nextTouch(_ sender: Any) {
        self.selectNext()
    }
}
