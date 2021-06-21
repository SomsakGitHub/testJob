//
//  TransactionViewController.swift
//  Pouch
//
//  Created by somsak on 1/6/2564 BE.
//

import UIKit

class TransactionViewController: UIViewController {
    
    @IBOutlet weak var dataTable: UITableView!
    
    var transactionCoreData = TransactionCoreData()
    var transactionArray: [TransactionEntity] = []
    var transactionData: TransactionEntity!
    var indexData = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        self.transactionArray = self.transactionCoreData.fetchTransaction()
        self.dataTable.reloadData()
    }
    
    @IBAction func createTransactionTouch(_ sender: Any) {
        self.transactionData = nil
        self.performSegue(withIdentifier: "goToCreateTransactionViewController", sender: self)
    }
    
    //MARK: Pass data with segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let createTransactionViewController = segue.destination as? CreateTransactionViewController {
            createTransactionViewController.indexData = self.indexData
            createTransactionViewController.transactionData = self.transactionData
            createTransactionViewController.delegate = self
        }
    }
}

extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transactionArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let transactionCell = tableView.dequeueReusableCell(withIdentifier: "transactionCell", for: indexPath) as! TransactionTableViewCell
        
        transactionCell.setView(data: self.transactionArray[indexPath.row])
        
        return transactionCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.transactionData = self.transactionArray[indexPath.row]
        self.performSegue(withIdentifier: "goToCreateTransactionViewController", sender: self)
    }
}

extension TransactionViewController: CreateTransactionViewControllerDelegate {
    func saveTransaction() {
        self.transactionArray = self.transactionCoreData.fetchTransaction()
        self.dataTable.reloadData()
    }
}
