//
//  ViewController.swift
//  pantipTest
//
//  Created by somsak on 10/6/2564 BE.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    private var viewModel: ViewModel!
    private var tag :Tag? = nil
    private var topic :Topic? = nil
    private var paginationTopicList: [TopicList?] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = ViewModel(view: self)
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        self.tableView.register(TagCell.nib(), forCellReuseIdentifier: TagCell.identifier)
        self.tableView.register(TopicCell.nib(), forCellReuseIdentifier: TopicCell.identifier)
        self.tableView.register(IndicatorCell.nib(), forCellReuseIdentifier: IndicatorCell.identifier)
        
        fetchData()
    }
    
    @objc func refresh(_ sender: AnyObject) {
        DispatchQueue.main.async {
            self.tag = nil
            self.topic = nil
            self.paginationTopicList = []
            self.refreshControl.endRefreshing()
        }
        fetchData()
    }

    func fetchData(){
        self.viewModel.fetchData()
    }
}

extension ViewController: ViewModelDelegate {
    func didFinishFetchData(tag: Tag?, topic: Topic?) {
        if self.paginationTopicList.isEmpty {
            for i in 0...5 {
                self.paginationTopicList.append(topic?.data?.topic_list[i])
            }
        }
        self.tag = tag
        self.topic = topic
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = HeaderView()
        if section == 0 {
            headerView.configView(text: "แท็กแนะนำ")
        }else{
            headerView.configView(text: "กระทู้พันทิป")
        }
        
        return headerView
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            if self.tag != nil {
                return 1
            }
        }else{
            if self.topic != nil {
                return self.paginationTopicList.count
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.paginationTopicList.count != self.topic?.data?.topic_list.count ?? 0 {
            if indexPath.row == (self.paginationTopicList.count - 1) {
                if let indicatorCell = tableView.dequeueReusableCell(withIdentifier: "indicatorCell", for: indexPath) as? IndicatorCell {
                    
                    return indicatorCell
                }
            }
        }
        
        if indexPath.section == 0 {
            if let tagCell = tableView.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath) as? TagCell {
                
                tagCell.tagData = self.tag
                
                return tagCell
            }
        }else{
            if let topicCell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as? TopicCell {
                
                topicCell.configTopicView(data: self.paginationTopicList[indexPath.row]!)
                return topicCell
            }
        }
        
        return UITableViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.topic != nil {
            if self.paginationTopicList.count != self.topic?.data?.topic_list.count ?? 0 {
                let positon = scrollView.contentOffset.y
                if positon > 10 {
                    DispatchQueue.main.async {
                        for i in 6...(self.topic?.data?.topic_list.count)! - 1 {
                            self.paginationTopicList.append(self.topic?.data?.topic_list[i])
                        }
                        self.tableView.reloadSections(IndexSet(integer: 1), with: .none)
                    }
                }
            }
        }
    }
}

