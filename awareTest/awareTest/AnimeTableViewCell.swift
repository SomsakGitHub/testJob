//
//  AnimeTableViewCell.swift
//  awareTest
//
//  Created by somsak on 21/6/2564 BE.
//

import UIKit

class AnimeTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var picImageView: UIImageView!
    
    static let identifier = "animeTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "AnimeTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configView(data: Anime){
        self.nameLabel.text = data.title
        
        if let url = URL(string: data.image_url) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.picImageView.image = image
                        }
                    }
                }
            }
        }
    }
    
}
