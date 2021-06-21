//
//  AutomateBoostViewController.swift
//  LivinginsiderTest
//
//  Created by somsak on 16/6/2564 BE.
//

import UIKit

class AutomateBoostViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var automateBoost = AutomateBoost()
    var isStartDate = true
    var isDate = true

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(InfoBoostTableViewCell.nib(), forCellReuseIdentifier: InfoBoostTableViewCell.identifier)
        self.tableView.register(DateBoostTableViewCell.nib(), forCellReuseIdentifier: DateBoostTableViewCell.identifier)
        self.tableView.register(DayBoostTableViewCell.nib(), forCellReuseIdentifier: DayBoostTableViewCell.identifier)
        self.tableView.register(TimeBoostTableViewCell.nib(), forCellReuseIdentifier: TimeBoostTableViewCell.identifier)
        self.tableView.register(SaveTableViewCell.nib(), forCellReuseIdentifier: SaveTableViewCell.identifier)
    }
    
    //MARK: Pass data with segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dateViewController = segue.destination as? DateViewController {
            dateViewController.isStartDate = self.isStartDate
            dateViewController.isDate = self.isDate
            dateViewController.delegate = self
        }else if let summaryAutomateBoostViewController = segue.destination as? SummaryAutomateBoostViewController {
            summaryAutomateBoostViewController.automateBoost = self.automateBoost
        }
    }
}

extension AutomateBoostViewController: UITableViewDelegate, UITableViewDataSource {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let infoBoostTableViewCell = tableView.dequeueReusableCell(withIdentifier: InfoBoostTableViewCell.identifier, for: indexPath) as! InfoBoostTableViewCell

            return infoBoostTableViewCell
        }else if indexPath.row == 1 {
            let dateBoostTableViewCell = tableView.dequeueReusableCell(withIdentifier: DateBoostTableViewCell.identifier, for: indexPath) as! DateBoostTableViewCell
            
            dateBoostTableViewCell.configView(data: self.automateBoost)
            
            dateBoostTableViewCell.selectStartDate = {
                self.isStartDate = true
                self.isDate = true
                self.performSegue(withIdentifier: "goToDateViewController", sender: self)
            }
            
            dateBoostTableViewCell.selectEndDate = {
                self.isStartDate = false
                self.isDate = true
                self.performSegue(withIdentifier: "goToDateViewController", sender: self)
            }
            
            return dateBoostTableViewCell
        }else if indexPath.row == 2 {
            let dayBoostTableViewCell = tableView.dequeueReusableCell(withIdentifier: DayBoostTableViewCell.identifier, for: indexPath) as! DayBoostTableViewCell
            
            dayBoostTableViewCell.configView(data: self.automateBoost)
            
            dayBoostTableViewCell.selectDay = { data in
                self.automateBoost.day?.append(data)
                        self.tableView.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .automatic)
            }
            
            return dayBoostTableViewCell
        }else if indexPath.row == 3 {
            let timeBoostTableViewCell = tableView.dequeueReusableCell(withIdentifier: TimeBoostTableViewCell.identifier, for: indexPath) as! TimeBoostTableViewCell
            
            timeBoostTableViewCell.selectTime = {
                self.isDate = false
                self.performSegue(withIdentifier: "goToDateViewController", sender: self)
            }
            
            if self.automateBoost.time!.count > 0{
                timeBoostTableViewCell.automateBoost = self.automateBoost
                timeBoostTableViewCell.collectionHeight.constant = 30 * CGFloat(self.automateBoost.time!.count)
                timeBoostTableViewCell.collectionView.reloadData()
            }
            
            return timeBoostTableViewCell
        }else if indexPath.row == 4 {
            let saveTableViewCell = tableView.dequeueReusableCell(withIdentifier: SaveTableViewCell.identifier, for: indexPath) as! SaveTableViewCell
            
            saveTableViewCell.selectNext = {
                self.performSegue(withIdentifier: "goToSummaryAutomateBoostViewController", sender: self)
            }
            
            return saveTableViewCell
        }
        
        return UITableViewCell()
    }
}

extension AutomateBoostViewController: DateViewControllerDelegate {
    func selectedDate(date: Date, isStartDate: Bool) {
        if isStartDate {
            self.automateBoost.startDate = date
        }else{
            self.automateBoost.endDate = date
        }
        
        self.tableView.reloadRows(at: [IndexPath.init(row: 1, section: 0)], with: .automatic)
    }
    
    func selectedTime(date: Date) {
        self.automateBoost.time?.append("\(date)")
        self.tableView.reloadRows(at: [IndexPath.init(row: 3, section: 0)], with: .automatic)
    }
}
