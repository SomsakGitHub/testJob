//
//  GithubTableViewCell.swift
//  clicknextTest
//
//  Created by somsak on 19/6/2564 BE.
//

import UIKit

class GithubTableViewCell: UITableViewCell {
    
    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var htmlUrlLabel: UILabel!
    
    static let identifier = "githubTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "GithubTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configView(data: Github){
        
        self.nameLabel.text = data.login
        self.htmlUrlLabel.text = data.html_url
        
        if let url = URL(string: data.avatar_url) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.userImageView.image = image
                        }
                    }
                }
            }
        }
    }
    
}
