//
//  TagCell.swift
//  pantipTest
//
//  Created by somsak on 11/6/2564 BE.
//

import UIKit

class TagCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tagData :Tag? = nil
    
    static let identifier = "tagCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TagCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        collectionView.register(TagCollectionViewCell.nib(), forCellWithReuseIdentifier: TagCollectionViewCell.iden)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension TagCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tagData?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let tagCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.iden, for: indexPath) as? TagCollectionViewCell {
            
            tagCollectionViewCell.configView(data: (self.tagData?.data[indexPath.row])!)
            
            return tagCollectionViewCell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 124)
    }
}
