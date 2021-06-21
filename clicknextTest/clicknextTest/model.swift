//
//  model.swift
//  clicknextTest
//
//  Created by somsak on 21/6/2564 BE.
//

import Foundation
import RxSwift
import RxCocoa

struct Github: Decodable {
    let avatar_url: String
    let login: String
    let html_url: String
}

struct Repositories: Decodable {
    let name: String
    let html_url: String
    let full_name: String
}

class GithubRepository {
    private let networkService = NetworkService()
    private let baseURLString = "https://api.github.com/users"
    
    func getGithubs() -> Observable<[Github]> {
        return networkService.execute(url: URL(string: baseURLString)!)
    }
    
    func getRepositories(ownerName: String) -> Observable<[Repositories]>{
        return networkService.execute(url: URL(string: baseURLString + "/\(ownerName)/repos")!)
    }
}

class NetworkService {
    func execute<T: Decodable>(url: URL) -> Observable<T> {
        return Observable.create { observable -> Disposable in
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data, let decoded = try? JSONDecoder().decode(T.self, from: data) else {
                    return
                }
                
                observable.onNext(decoded)
                observable.onCompleted()
            }
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
