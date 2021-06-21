//
//  transactionCoreData.swift
//  Pouch
//
//  Created by somsak on 1/6/2564 BE.
//

import Foundation
import UIKit
import CoreData

class TransactionCoreData {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let entity = "TransactionEntity"
    let nameKey = "name"
    let amountKey = "amount"
    let typeKey = "type"
    let categoryKey = "category"
    let dateKey = "date"
    let noteKey = "note"
    
    var transactionArray: [TransactionEntity] = []
    
    func saveTransaction(data: Transaction){
        let newObject = NSEntityDescription.insertNewObject(forEntityName: entity, into: context)
        
        newObject.setValue(data.name, forKey: nameKey)
        newObject.setValue(data.price, forKey: amountKey)
        newObject.setValue(data.type, forKey: typeKey)
        newObject.setValue(data.category, forKey: categoryKey)
        newObject.setValue(data.date, forKey: dateKey)
        newObject.setValue(data.note, forKey: noteKey)
        
        do {
            try context.save()
            print("save success", newObject.setValue(data.name, forKey: nameKey) as Any)
            
        } catch  {
            print(error)
        }
    }
    
    func fetchTransaction() -> [TransactionEntity]{
        
        do {
            self.transactionArray = try self.context.fetch(TransactionEntity.fetchRequest())
        } catch  {
            print(error)
        }
        
        print("self.transactionArray.count", self.transactionArray.count)
        print("self.transactionArray.last?.text", self.transactionArray.last?.amount as Any)
        
        return self.transactionArray
    }
    
    func editTransaction(index: Int, data: Transaction){
        
        do {
            self.transactionArray = try self.context.fetch(TransactionEntity.fetchRequest())

            self.transactionArray[index].setValue(data.name, forKey: nameKey)
            self.transactionArray[index].setValue(data.price, forKey: amountKey)
            self.transactionArray[index].setValue(data.type, forKey: typeKey)
            self.transactionArray[index].setValue(data.category, forKey: categoryKey)
            self.transactionArray[index].setValue(data.date, forKey: dateKey)
            self.transactionArray[index].setValue(data.note, forKey: noteKey)
            
            try context.save()
        } catch  {
            print(error)
        }
    }
    
    func deleteTransaction(data: TransactionEntity){
        do {
            self.context.delete(data)
            print("delete \(data) success")
            try self.context.save()
        } catch {
            print(error)
        }
    }
}

