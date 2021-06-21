//
//  CreateTransactionTableViewCell.swift
//  Pouch
//
//  Created by somsak on 1/6/2564 BE.
//

import UIKit

class CreateTransactionTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var labelTextField: UITextField!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var categoryButton: UIButton!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteTextField: UITextField!
    
    var selectType: (() -> Void) = {}
    var selectCategory: (() -> Void) = {}
    var selectDate: (() -> Void) = {}

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func typeSpinnerTouch(_ sender: Any) {
        self.selectType()
    }
    
    @IBAction func categorySpinnerTouch(_ sender: Any) {
        self.selectCategory()
    }
    
    @IBAction func dateTouch(_ sender: Any) {
        self.selectDate()
    }
    
    func configureCategoryCell(isSelectHidden: Bool ,data: String){
        self.categoryButton.isHidden = isSelectHidden
        self.categoryTextField.text = data
    }
    
    func configuraView(){
        self.noteTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 100
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
