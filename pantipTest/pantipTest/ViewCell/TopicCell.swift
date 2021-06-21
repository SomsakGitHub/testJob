//
//  TopicCell.swift
//  pantipTest
//
//  Created by somsak on 11/6/2564 BE.
//

import UIKit

class TopicCell: UITableViewCell {
    
    @IBOutlet weak var frameImageView: UIView!
    @IBOutlet weak var topicImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var viewCountLabel: UILabel!
    
    static let identifier = "topicCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TopicCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configTopicView(data: TopicList){
    
        if let url = URL(string: data.cover_img ?? "") {
            self.frameImageView.isHidden = false
            let imageData = try? Data(contentsOf: url)
            if imageData != nil{
                self.topicImageView.image = UIImage(data: imageData!)
            }else{
                self.frameImageView.isHidden = true
            }
        }else{
            self.frameImageView.isHidden = true
        }
        
        self.titleLabel.text = data.title
        self.authorLabel.text = data.author
        self.viewCountLabel.text = calcUnit(distance: data.view_count ?? "")
    }
    
    func calcUnit(distance: String) -> String {
        
        let formater = NumberFormatter()
        formater.numberStyle = .decimal
        formater.locale = Locale(identifier: "en_AU")
        let number = formater.number(from: distance) ?? 0
        let distanceInt = Int(truncating: number)
        var data = ""
        
        if distanceInt >= 1000000 {
            data = "\(distanceInt/1000000)m"
        }else if distanceInt >= 1000 {
            data = "\(distanceInt/1000)K"
        }else if distanceInt < 1000 {
            data = distance
        }
        
        return data
    }
}
