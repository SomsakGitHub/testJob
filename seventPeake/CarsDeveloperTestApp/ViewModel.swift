//
//  ViewModel.swift
//  CarsDeveloperTestApp
//
//  Created by somsak on 22/4/2564 BE.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ViewModelDelegate {
    func didFinishFetchData(data: [ArticleEntity]?)
}

@available(iOS 13.0, *)
class ViewModel{
    
    private let viewModelDelegate: ViewModelDelegate?

    init(view: ViewModelDelegate) {
        self.viewModelDelegate = view
    }
    
    var articleCoreData = ArticleCoreData()
    var articleArray: [ArticleEntity] = []
    var articles :[Article]? = []
    
    func fetchData(){
        let service = ServiceWrapper()
        var urlRequest = URLRequest(url:  URL(string: "https://www.apphusetreach.no/application/119267/article/get_articles_list")!)
        urlRequest.httpMethod = HTTPMethod.get.rawValue
        urlRequest.timeoutInterval = 10 // secs
        
        service.serviceResponse(request: urlRequest) { (response, status) in
            
            switch status {
                case .success:
                    let json: JSON = JSON(response as Any)
                    let decoder = JSONDecoder()
                    
                    do {
                        let data = try json["content"].rawData()
                        self.articles = try decoder.decode([Article].self, from: data)
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                    self.articleCoreData.deleteArticleEntity()
                    
                    for (i, _) in self.articles!.enumerated() {
                        self.articleCoreData.saveArticleEntity(data: self.articles![i])
                        let article = self.articleCoreData.fetchArticleEntity()
                        if let content = self.articles![i].content.first {
                            self.articleCoreData.saveContentEntity(data: content, relation: article[i])
                        }
                    }
                    
                    self.articleArray = self.articleCoreData.fetchArticleEntity()
                    self.viewModelDelegate!.didFinishFetchData(data: self.articleArray)
                    
                    break
                default :
                    self.viewModelDelegate!.didFinishFetchData(data: nil)
                    break
            }
        }
    }
}
