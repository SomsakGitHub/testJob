//
//  topic.swift
//  pantipTest
//
//  Created by somsak on 10/6/2564 BE.
//

struct Topic: Codable {
    let success: Bool?
    let data: TopicData?
}

struct TopicData: Codable {
    let topic_list: [TopicList?]
}

struct TopicList: Codable {
    let title: String?
    let author: String?
    let view_count: String?
    let cover_img: String?
}
