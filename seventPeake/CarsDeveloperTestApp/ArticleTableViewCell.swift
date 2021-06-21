//
//  ArticleTableViewCell.swift
//  CarsDeveloperTestApp
//
//  Created by somsak on 25/4/2564 BE.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpView(data: ArticleEntity){
        self.carImage.image = UIImage(data: data.image!)
        self.titleLabel.text = data.title
        self.dateTimeLabel.text = data.dateTime
        self.contentLabel.text = data.contentRelationship?.descriptionStr
    }
}
