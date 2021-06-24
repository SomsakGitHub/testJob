//
//  ViewController.swift
//  awareTest
//
//  Created by somsak on 21/6/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let animeRepository = AnimeRepository()
    private let disposeBag = DisposeBag()
    
    var anime: Anime? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(AnimeTableViewCell.nib(), forCellReuseIdentifier: AnimeTableViewCell.identifier)
        
        let reposObservable = animeRepository.getAnime().share()
        
        reposObservable.flatMap { repos -> Observable<[Anime]> in
            
            return self.animeRepository.getAnime()
        }.bind(to: tableView.rx.items(cellIdentifier: AnimeTableViewCell.identifier, cellType: AnimeTableViewCell.self)) { index, anime, cell in
            cell.configView(data: anime)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Anime.self).bind { anime in
            self.anime = anime
            self.performSegue(withIdentifier: "goToDetail", sender: self)
        }.disposed(by: disposeBag)
    }
    
    //MARK: Pass data with segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailViewController = segue.destination as? DetailViewController {
            detailViewController.anime = self.anime
        }
    }
}

struct Anime: Decodable {
    let title: String
    let image_url: String
    let total_episodes: Int
    let season_name: String
    let season_year: Int
}

class AnimeRepository {
    private let networkService = NetworkService()
    private let baseURLString = "https://api.jikan.moe/v3/user/Nekomata1037/animelist/all"
    
    func getAnime() -> Observable<[Anime]> {
        return networkService.execute(url: URL(string: baseURLString)!)
    }
}

class NetworkService {
    
    func execute<T: Decodable>(url: URL) -> Observable<T> {
        return Observable.create { observable -> Disposable in
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in

                let json: JSON = JSON(data as Any)
                
                guard let _ = data, let decoded = try? JSONDecoder().decode(T.self, from: json["anime"].rawData()) else {

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

