//
//  TransactionTableViewCell.swift
//  Pouch
//
//  Created by somsak on 1/6/2564 BE.
//

import UIKit

class TransactionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setView(data: TransactionEntity){
        self.nameLabel.text = data.name
    }

}
