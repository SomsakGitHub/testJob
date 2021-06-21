//
//  DateViewController.swift
//  LivinginsiderTest
//
//  Created by somsak on 17/6/2564 BE.
//

import UIKit

protocol DateViewControllerDelegate {
    func selectedDate(date: Date, isStartDate: Bool)
    func selectedTime(date: Date)
}

class DateViewController: UIViewController {
    
    @IBOutlet var datePicker: UIDatePicker!
    
    var delegate: DateViewControllerDelegate!
    
    var isStartDate = true
    var isDate = true

    override func viewDidLoad() {
        super.viewDidLoad()

        if self.isDate {
            datePicker.datePickerMode = .date
        }else{
            datePicker.datePickerMode = .time
        }
    }
    
    @IBAction func dismissTouch(_ sender: Any) {
        self.dismiss(animated: true) {
            if self.isDate {
                self.delegate.selectedDate(date: self.datePicker.date, isStartDate: self.isStartDate)
            }else{
                self.delegate.selectedTime(date: self.datePicker.date)
            }
        }
    }
}
