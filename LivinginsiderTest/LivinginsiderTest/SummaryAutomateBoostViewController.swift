//
//  SummaryAutomateBoostViewController.swift
//  LivinginsiderTest
//
//  Created by somsak on 17/6/2564 BE.
//

import UIKit

class SummaryAutomateBoostViewController: UIViewController {
    
    var automateBoost: AutomateBoost? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("automateBoost", automateBoost?.startDate)
        print("startDate", automateBoost?.endDate)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
