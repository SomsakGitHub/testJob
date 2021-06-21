//
//  ViewController.swift
//  clicknextTest
//
//  Created by somsak on 19/6/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let githubRepository = GithubRepository()
    private let disposeBag = DisposeBag()
    
    var userName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(GithubTableViewCell.nib(), forCellReuseIdentifier: GithubTableViewCell.identifier)
        
        let reposObservable = githubRepository.getGithubs().share()
        
        reposObservable.flatMap { repos -> Observable<[Github]> in
            
            return self.githubRepository.getGithubs()
        }.bind(to: tableView.rx.items(cellIdentifier: GithubTableViewCell.identifier, cellType: GithubTableViewCell.self)) { index, github, cell in
            cell.configView(data: github)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Github.self).bind { product in
            self.userName = product.login
            self.performSegue(withIdentifier: "goToRepositories", sender: self)
        }.disposed(by: disposeBag)
    }
    
    //MARK: Pass data with segue.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let repositoriesViewController = segue.destination as? RepositoriesViewController {
            repositoriesViewController.userName = self.userName
        }
    }
}
