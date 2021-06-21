//
//  userCoreData.swift
//  DTCTest
//
//  Created by somsak on 19/6/2564 BE.
//

import Foundation
import UIKit
import CoreData

class UserCoreData {
    
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let entity = "UserEntity"
    let usernameKey = "username"
    let passwordKey = "password"
    let nameKey = "name"
    let sernameKey = "sername"
    let idCardKey = "idCard"
    let phoneKey = "phone"
    let imageKey = "image"
    
    var userEntityArray: [UserEntity] = []
    
    func saveUserEntity(data: [String], image: Data){
        let newObject = NSEntityDescription.insertNewObject(forEntityName: entity, into: context)
        
        newObject.setValue(data[0], forKey: usernameKey)
        newObject.setValue(data[1], forKey: passwordKey)
        newObject.setValue(data[2], forKey: nameKey)
        newObject.setValue(data[3], forKey: sernameKey)
        newObject.setValue(data[4], forKey: idCardKey)
        newObject.setValue(data[5], forKey: phoneKey)
        newObject.setValue(image, forKey: imageKey)
        
        do {
            try context.save()
            print("save success", newObject.setValue(data[1], forKey: passwordKey) as Any)
            
        } catch  {
            print(error)
        }
    }
    
    func fetchUserEntity() -> [UserEntity]{

        do {
            self.userEntityArray = try self.context.fetch(UserEntity.fetchRequest())
        } catch  {
            print(error)
        }

        print("self.userEntityArray.count", self.userEntityArray.count)
        print("self.userEntityArray.last?", self.userEntityArray.last?.password as Any)

        return self.userEntityArray
    }
}
