//
//  TagCollectionViewCell.swift
//  pantipTest
//
//  Created by somsak on 13/6/2564 BE.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIView!
    @IBOutlet var image: UIImageView!
    @IBOutlet var primaryView: UIView!
    @IBOutlet var primaryLabel: UILabel!
    
    static let iden = "TagCollectionViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TagCollectionViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configView(data: TagData){
        
        imageView.layer.cornerRadius = 4
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        primaryView.layer.cornerRadius = 4
        primaryView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        if let url = URL(string: data.image_url[1] ?? "") {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.image.image = image
                        }
                    }
                }
            }
        }
        
        self.primaryLabel.text = data.name
    }
}
