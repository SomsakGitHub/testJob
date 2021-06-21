//
//  ViewModel.swift
//  pantipTest
//
//  Created by somsak on 10/6/2564 BE.
//

import SwiftyJSON

protocol ViewModelDelegate {
    func didFinishFetchData(tag: Tag?, topic: Topic?)
}

class ViewModel{

    private var viewModelDelegate: ViewModelDelegate?
    private var tag :Tag? = nil
    private var topic :Topic? = nil
    private let dispatchGroup = DispatchGroup()

    init(view: ViewModelDelegate) {
        self.viewModelDelegate = view
    }
    
    func fetchData(){
        
        dispatchGroup.enter()
        fetchTag()
        dispatchGroup.enter()
        fetchTopic()
        dispatchGroup.notify(queue: .main) {
            self.viewModelDelegate?.didFinishFetchData(tag: self.tag ?? nil, topic: self.topic ?? nil)
        }
    }
    
    func fetchTag(){
        let path = Bundle.main.path(forResource: "tags", ofType: "json")!
        let jsonString = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
        let json = JSON(parseJSON: jsonString!)
        let decoder = JSONDecoder()
        
        DispatchQueue.main.async {
            do {
                let data = try json.rawData()
                self.tag = try decoder.decode(Tag.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
            self.dispatchGroup.leave()
        }
    }
    
    func fetchTopic(){
        let path = Bundle.main.path(forResource: "topics", ofType: "json")!
        let jsonString = try? String(contentsOfFile: path, encoding: String.Encoding.utf8)
        let json = JSON(parseJSON: jsonString!)
        let decoder = JSONDecoder()
        
        DispatchQueue.main.async {
            do {
                let data = try json.rawData()
                self.topic = try decoder.decode(Topic.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
            self.dispatchGroup.leave()
        }
    }
}
