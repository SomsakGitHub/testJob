//
//  TimeBoostTableViewCell.swift
//  LivinginsiderTest
//
//  Created by somsak on 17/6/2564 BE.
//

import UIKit

class TimeBoostTableViewCell: UITableViewCell {
    
    static let identifier = "timeBoostTableViewCell"
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var collectionHeight: NSLayoutConstraint!
    
    var selectTime: (() -> Void) = {}
    var automateBoost: AutomateBoost? = nil
    
    static func nib() -> UINib {
        return UINib(nibName: "TimeBoostTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.register(TimeCollectionViewCell.nib(), forCellWithReuseIdentifier: TimeCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selectTimeTouch(_ sender: Any) {
        self.selectTime()
    }
}

extension TimeBoostTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.automateBoost?.time?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let timeCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: TimeCollectionViewCell.identifier, for: indexPath) as? TimeCollectionViewCell {
            
            timeCollectionViewCell.timeLabel.text = automateBoost?.time?[indexPath.row]

            return timeCollectionViewCell
        }

        return UICollectionViewCell()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 280, height: 22)
    }
}
