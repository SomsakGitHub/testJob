//
//  Model.swift
//  CarsDeveloperTestApp
//
//  Created by somsak on 22/4/2564 BE.
//

struct Article: Codable {
    var id, created, changed: Int64
    var title, ingress, image, dateTime: String
    var tags: [String]
    var content: [Content]
}

struct Content: Codable {
    let type, subject, description: String
}


