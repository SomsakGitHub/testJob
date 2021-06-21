//
//  CreateTransactionViewController.swift
//  Pouch
//
//  Created by somsak on 1/6/2564 BE.
//

import UIKit
import CoreData

protocol CreateTransactionViewControllerDelegate {
    func saveTransaction()
}

class CreateTransactionViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var deleteTransactionButton: UIButton!
    @IBOutlet weak var dataTable: UITableView!
    
    var delegate: CreateTransactionViewControllerDelegate!
    
    var transactionCoreData = TransactionCoreData()
    var transaction = Transaction()
    var spinnerType: SpinnerType = .type
    
    var transactionArray: [TransactionEntity] = []
    var transactionData: TransactionEntity!
    var transactionSpinnerType = ["income", "expense"]
    var transactionSpinnerCategory: [String] = []
    var spinnerData: [String] = []
    var spinnerDataDelegate = ""
    var dateDelegate = ""
    var indexData = 0
    
    var getAmountOnTextField:(() -> (String))!
    var getLebelOnTextField:(() -> (String))!
    var getTypeOnLabel:(() -> (String))!
    var getCategoryOnTextField:(() -> (String))!
    var getdateOnLabel:(() -> (String))!
    var getnoteOnTextField:(() -> (String))!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.dismissKeyboardOnDidTabView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Called before content view is added to app's view hierarchy.
        configureViewController()
    }
    
    func dismissKeyboardOnDidTabView(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: Pass data with segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let spinnerViewController = segue.destination as? SpinnerViewController {
            spinnerViewController.spinnerType = self.spinnerType
            spinnerViewController.spinnerData = self.spinnerData
            spinnerViewController.delegate = self
        }else if let calendarViewController = segue.destination as? CalendarViewController {
            calendarViewController.delegate = self
        }
    }
    
    @IBAction func dismissTouch(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func deleteTransactionTouch(_ sender: Any) {
        self.dismiss(animated: true) {
            self.transactionCoreData.deleteTransaction(data: self.transactionData)
            self.delegate.saveTransaction()
        }
    }
    
    @IBAction func saveTransactionTouch(_ sender: Any) {
        transaction.name = self.getLebelOnTextField()
        transaction.price = self.getAmountOnTextField()
        transaction.type = self.getTypeOnLabel()
        transaction.category = self.getCategoryOnTextField()
        transaction.date = self.getdateOnLabel()
        transaction.note = self.getnoteOnTextField()
        
        if transaction.name == "" || transaction.price == "" || transaction.type == "" || transaction.category == "" || transaction.date == "" || transaction.note == "" {
            let alert = UIAlertController(title: "Validation", message: "Please enter data.", preferredStyle: UIAlertController.Style.alert)
                    
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default))
                    
                    self.present(alert, animated: true, completion: nil)
        }else{
            self.dismiss(animated: true) {
                if self.transactionData == nil {
                    self.transactionCoreData.saveTransaction(data: self.transaction)
                }else{
                    self.transactionCoreData.editTransaction(index: self.indexData, data: self.transaction)
                }
                
                self.delegate.saveTransaction()
            }
        }
    }
    
    func configureViewController(){
        
        if self.transactionData == nil {
            self.deleteTransactionButton.isHidden = true
            self.titleLabel.text = "Create"
            self.dataTable.reloadData()
        }else{
            self.deleteTransactionButton.isHidden = false
            self.titleLabel.text = "Edit"
        }
        
        self.transactionArray = self.transactionCoreData.fetchTransaction()
        for i in self.transactionArray {
            self.transactionSpinnerCategory.append(i.category ?? "")
        }
    }
    
    func callSpinner(isType: Bool){
        if isType {
            self.spinnerType = .type
            self.spinnerData = self.transactionSpinnerType
        }else{
            self.spinnerType = .category
            self.spinnerData = self.transactionSpinnerCategory
        }
        self.performSegue(withIdentifier: "goToSpinner", sender: self)
    }
    
    func calendarView(){
        self.performSegue(withIdentifier: "goToCalendar", sender: self)
    }
}

extension CreateTransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 120
        }else{
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = CreateTransactionTableViewCell()
        
        switch indexPath.row {
        case 0:
            let amountCell = tableView.dequeueReusableCell(withIdentifier: "amountCell", for: indexPath) as! CreateTransactionTableViewCell
            
            amountCell.amountView.layer.cornerRadius = 8
            
            if self.transactionData != nil {
                amountCell.amountTextField.text = self.transactionData.amount
            }
            
            self.getAmountOnTextField = {
                return amountCell.amountTextField.text!
            }
            
            cell = amountCell
            break
        case 1:
            let labelCell = tableView.dequeueReusableCell(withIdentifier: "labelCell", for: indexPath) as! CreateTransactionTableViewCell
            
            if self.transactionData != nil {
                labelCell.labelTextField.text = self.transactionData.name
                labelCell.labelTextField.isEnabled = false
            }
            
            self.getLebelOnTextField = {
                return labelCell.labelTextField.text!
            }
            
            cell = labelCell
            break
        case 2:
            let typeCell = tableView.dequeueReusableCell(withIdentifier: "typeCell", for: indexPath) as! CreateTransactionTableViewCell
            
            if self.spinnerDataDelegate.isEmpty {
                if self.transactionData != nil {
                    typeCell.typeLabel.text = self.transactionData.type
                }
            }else{
                typeCell.typeLabel.text = self.spinnerDataDelegate
            }
            
            typeCell.selectType = {
                self.callSpinner(isType: true)
            }
            
            self.getTypeOnLabel = {
                return typeCell.typeLabel.text ?? ""
            }
            
            cell = typeCell
            break
        case 3:
            let categoryCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CreateTransactionTableViewCell
            
            if self.transactionSpinnerCategory.count > 0 {
                categoryCell.configureCategoryCell(isSelectHidden: false ,data: self.spinnerDataDelegate)
                if self.transactionData != nil {
                    categoryCell.categoryTextField.text = self.transactionData.category
                }
            }else{
                categoryCell.configureCategoryCell(isSelectHidden: true ,data: self.spinnerDataDelegate)
            }
            
            categoryCell.selectCategory = {
                self.callSpinner(isType: false)
            }
            
            self.getCategoryOnTextField = {
                return categoryCell.categoryTextField.text!
            }
            
            cell = categoryCell
            break
        case 4:
            let dateCell = tableView.dequeueReusableCell(withIdentifier: "dateCell", for: indexPath) as! CreateTransactionTableViewCell
            
            if self.dateDelegate.isEmpty {
                if self.transactionData != nil {
                    dateCell.dateLabel.text = self.transactionData.date
                }
            }else{
                dateCell.dateLabel.text = self.dateDelegate
            }
            
            dateCell.selectDate = {
                self.calendarView()
            }

            self.getdateOnLabel = {
                return dateCell.dateLabel.text ?? ""
            }
            
            cell = dateCell
            break
        case 5:
            let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as! CreateTransactionTableViewCell
            
            if self.transactionData != nil {
                noteCell.noteTextField.text = self.transactionData.note
            }
            
            noteCell.configuraView()

            self.getnoteOnTextField = {
                return noteCell.noteTextField.text ?? ""
            }
            
            cell = noteCell
            break
        default:
            break
        }
        
        return cell
    }
}

extension CreateTransactionViewController: SpinnerViewControllerViewControllerDelegate {
    func spinnerSelected(data: String) {
        self.spinnerDataDelegate = data
        if self.spinnerType == .type {
            self.dataTable.reloadRows(at: [IndexPath.init(row: 2, section: 0)], with: .automatic)
        }else{
            self.dataTable.reloadRows(at: [IndexPath.init(row: 3, section: 0)], with: .automatic)
        }
    }
}

extension CreateTransactionViewController: CalendarViewControllerDelegate {
    func setDateSelected(date: String) {
        self.dateDelegate = date
        self.dataTable.reloadRows(at: [IndexPath.init(row: 4, section: 0)], with: .automatic)
    }
}
