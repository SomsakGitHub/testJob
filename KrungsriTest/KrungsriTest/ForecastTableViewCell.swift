//
//  ForecastTableViewCell.swift
//  KrungsriTest
//
//  Created by somsak on 12/6/2564 BE.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    static let identifier = "forecastTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ForecastTableViewCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configView(data: ForecastData?){
        self.dateTimeLabel.text = data?.dt_txt
        let celsius = (data?.main.temp ?? 0.0) - 273.15
        self.temperatureLabel.text = String(format: "%.0f", celsius) + " C."
        self.humidityLabel.text = String(data?.main.humidity ?? 0)
    }
}
