//
//  CalendarViewController.swift
//  Pouch
//
//  Created by somsak on 2/6/2564 BE.
//

import UIKit
import FSCalendar

protocol CalendarViewControllerDelegate {
    func setDateSelected(date: String)
}

class CalendarViewController: UIViewController {
    
    var delegate: CalendarViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.dismiss(animated: true) {
            self.delegate.setDateSelected(date: date.parseToStringBCFormat(dateFormat: "dd-MM-yyyy"))
        }
    }
}
