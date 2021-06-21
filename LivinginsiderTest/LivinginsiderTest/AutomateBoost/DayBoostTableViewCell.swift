//
//  DayBoostTableViewCell.swift
//  LivinginsiderTest
//
//  Created by somsak on 17/6/2564 BE.
//

import UIKit

class DayBoostTableViewCell: UITableViewCell {
    
    @IBOutlet var sundayButton: UIButton!
    @IBOutlet var mondayButton: UIButton!
    @IBOutlet var tuesdayButton: UIButton!
    @IBOutlet var wednesdayButton: UIButton!
    @IBOutlet var thursdayButton: UIButton!
    @IBOutlet var fridayButton: UIButton!
    @IBOutlet var saturdayButton: UIButton!
    
    static let identifier = "dayBoostTableViewCell"
    var selectDay: ((_ day: String) -> Void) = {_ in }
    
    static func nib() -> UINib {
        return UINib(nibName: "DayBoostTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selectDayTouch(_ sender: UIButton) {
        self.selectDay(sender.titleLabel?.text ?? "")
    }
    
    func configView(data: AutomateBoost){
        if data.day != nil{
            for (_, j) in data.day!.enumerated() {
                if j == sundayButton.titleLabel!.text {
                    sundayButton.backgroundColor = UIColor.red
                }
                
                if j == mondayButton.titleLabel!.text {
                    mondayButton.backgroundColor = UIColor.red
                }
                
                if j == tuesdayButton.titleLabel!.text {
                    tuesdayButton.backgroundColor = UIColor.red
                }
                
                if j == wednesdayButton.titleLabel!.text {
                    wednesdayButton.backgroundColor = UIColor.red
                }
                
                if j == thursdayButton.titleLabel!.text {
                    thursdayButton.backgroundColor = UIColor.red
                }
                
                if j == fridayButton.titleLabel!.text {
                    fridayButton.backgroundColor = UIColor.red
                }
                
                if j == saturdayButton.titleLabel!.text {
                    saturdayButton.backgroundColor = UIColor.red
                }
            }
        }
    }
}
