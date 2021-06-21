//
//  RepositoriesViewController.swift
//  clicknextTest
//
//  Created by somsak on 19/6/2564 BE.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let githubRepository = GithubRepository()
    private let disposeBag = DisposeBag()
    
    var userName = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(RepositoriesTableViewCell.nib(), forCellReuseIdentifier: RepositoriesTableViewCell.identifier)
        
        let reposObservable = githubRepository.getRepositories(ownerName: self.userName).share()
        
        reposObservable.flatMap { repos -> Observable<[Repositories]> in
            return self.githubRepository.getRepositories(ownerName: self.userName)
        }.bind(to: tableView.rx.items(cellIdentifier: RepositoriesTableViewCell.identifier, cellType: RepositoriesTableViewCell.self)) { index, repositories, cell in
            cell.configView(data: repositories)
        }.disposed(by: disposeBag)
    }
}
