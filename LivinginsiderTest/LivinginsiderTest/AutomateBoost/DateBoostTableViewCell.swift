//
//  DateBoostTableViewCell.swift
//  LivinginsiderTest
//
//  Created by somsak on 16/6/2564 BE.
//

import UIKit

class DateBoostTableViewCell: UITableViewCell {
    
    static let identifier = "dateBoostTableViewCell"
    
    @IBOutlet var startDateLabel: UILabel!
    @IBOutlet var endDateLabel: UILabel!
    
    var selectStartDate: (() -> Void) = {}
    var selectEndDate: (() -> Void) = {}
    
    static func nib() -> UINib {
        return UINib(nibName: "DateBoostTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func startDateTouch(_ sender: Any) {
        self.selectStartDate()
    }
    
    @IBAction func finishDateTouch(_ sender: Any) {
        self.selectEndDate()
    }
    
    func configView(data: AutomateBoost){
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        
        if let startDate = data.startDate {
            self.startDateLabel.text = formatter.string(from: startDate)
        }
        
        if let endDate = data.endDate {
            self.endDateLabel.text = formatter.string(from: endDate)
        }
    }
}
