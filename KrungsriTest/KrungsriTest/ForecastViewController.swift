//
//  ForecastViewController.swift
//  KrungsriTest
//
//  Created by somsak on 12/6/2564 BE.
//

import UIKit

class ForecastViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var forecastData: [ForecastData?] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(ForecastTableViewCell.nib(), forCellReuseIdentifier: ForecastTableViewCell.identifier)
    }
}

extension ForecastViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.forecastData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let forecastCell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath) as? ForecastTableViewCell {
            
            forecastCell.configView(data: self.forecastData[indexPath.row])
            
            return forecastCell
        }
        
        return UITableViewCell()
    }
}
