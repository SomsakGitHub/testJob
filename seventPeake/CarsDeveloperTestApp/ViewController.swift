//
//  ViewController.swift
//  CarsDeveloperTestApp
//
//  Created by somsak on 20/4/2564 BE.
//

import UIKit

@available(iOS 13.0, *)
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: ViewModel!

    var articleCoreData = ArticleCoreData()
    var articles :[ArticleEntity]? = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = ViewModel(view: self)
        fetchData()
    }
    
    func fetchData(){
        
        if Connectivity.isConnectedToInternet {
            self.viewModel.fetchData()
         } else {
            self.articles = self.articleCoreData.fetchArticleEntity()
            self.tableView.reloadData()
        }
    }
}

@available(iOS 13.0, *)
extension ViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles!.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 407
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let articleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "articleTableViewCell", for: indexPath) as! ArticleTableViewCell

        articleTableViewCell.setUpView(data: self.articles![indexPath.row])

        return articleTableViewCell
    }
}

@available(iOS 13.0, *)
extension ViewController: ViewModelDelegate {

    func didFinishFetchData(data: [ArticleEntity]?) {
        self.articles = data
        self.tableView.reloadData()
    }
}

