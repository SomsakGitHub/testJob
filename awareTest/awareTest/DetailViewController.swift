//
//  DetailViewController.swift
//  awareTest
//
//  Created by somsak on 22/6/2564 BE.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var picImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var totalEpisodesLabel: UILabel!
    @IBOutlet var seasonNameLabel: UILabel!
    @IBOutlet var seasonYearLabel: UILabel!
    
    var anime: Anime? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
    }

    func configView(){
        self.nameLabel.text = "name: " + anime!.title
        self.totalEpisodesLabel.text = "total episodes: \(anime?.total_episodes ?? 0)"
        self.seasonNameLabel.text = "season name: " + anime!.season_name
        self.seasonYearLabel.text = "season year: \(anime?.season_year ?? 0)"
        
        if let url = URL(string: anime!.image_url) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.picImageView.image = image
                        }
                    }
                }
            }
        }
    }
}
