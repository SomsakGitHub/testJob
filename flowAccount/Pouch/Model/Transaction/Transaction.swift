//
//  Transaction.swift
//  Pouch
//
//  Created by Narong Kanthanu on 26/3/2564 BE.
//

import Foundation
import ObjectMapper

class Transaction: NSObject, NSCoding, Mappable {
    
    var name: String = ""
    var type: String = ""
    var category: String = ""
    var price: String = ""
    var date: String = ""
    var note: String = ""
    
    func mapping(map: Map) {
        name <- map["name"]
        type <- map["type"]
        category <- map["category"]
        price <- map["price"]
        date <- map["date"]
        note <- map["note"]
    }
    
    override init() {
        // unimplement
    }
    
    required init?(map: Map) {
        // unimplement
    }
    
    required init?(coder aDecoder: NSCoder) {
        // unimplement
    }
    
    func encode(with aCoder: NSCoder) {
        // unimplement
    }
    
    convenience init?(data: [String:Any]){
        self.init(JSON: data)
    }

}

