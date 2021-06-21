//
//  SpinnerViewController.swift
//  Pouch
//
//  Created by somsak on 1/6/2564 BE.
//

import UIKit

protocol SpinnerViewControllerViewControllerDelegate {
    func spinnerSelected(data: String)
}

class SpinnerViewController: UIViewController {
    
    var spinnerType: SpinnerType = .type
    var spinnerData: [String] = []
    var transactionType = ""
    
    var delegate: SpinnerViewControllerViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        setupPicker()
    }
    
    static func createSpinner() -> SpinnerViewController {
        let spinner: SpinnerViewController = UIStoryboard(name: "Spinner", bundle: nil)
            .instantiateViewController(withIdentifier: "SpinnerViewController") as! SpinnerViewController
        
        return spinner
    }
    
    @IBAction func selectTypeTouch(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate.spinnerSelected(data: self.transactionType)
        }
    }
}

//MARK: Extension datasource and delegate.
extension SpinnerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.spinnerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.transactionType = self.spinnerData[row]
        
        return self.spinnerData[row]
    }
}
