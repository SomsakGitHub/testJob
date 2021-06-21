//
//  tag.swift
//  pantipTest
//
//  Created by somsak on 10/6/2564 BE.
//

struct Tag: Codable {
    let success: Bool?
    let data: [TagData?]
}

struct TagData: Codable {
    let name: String?
    let image_url: [String?]
}
