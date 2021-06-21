//
//  RepositoriesTableViewCell.swift
//  clicknextTest
//
//  Created by somsak on 19/6/2564 BE.
//

import UIKit

class RepositoriesTableViewCell: UITableViewCell {
    
    @IBOutlet var fullNameLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var urlLabel: UILabel!
    
    static let identifier = "repositoriesTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "RepositoriesTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configView(data: Repositories){
        self.fullNameLabel.text = "full name: \(data.full_name)"
        self.nameLabel.text = "name repos: \(data.name)"
        self.urlLabel.text = "url: \(data.html_url)" 
    }
}
