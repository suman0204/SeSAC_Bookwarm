//
//  DetailViewController.swift
//  Bookwarm
//
//  Created by 홍수만 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var moviePosterImage: UIImageView!

    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieInfoLabel: UILabel!
    @IBOutlet var movieRateLabel: UILabel!
    @IBOutlet var movieOverviewTitleLabel: UILabel!
    @IBOutlet var movieOverviewLabel: UILabel!
    
    var row: Movie = Movie(title: "정보없음", releaseDate: "정보없음", runtime: 0, overview: "정보없음", rate: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDetailView(row: row)
        
    }
    
    func configureDetailView(row: Movie) {
        
        title = row.title
        
        moviePosterImage.image = UIImage(named: row.title)
        
        movieTitleLabel.text = row.title
        
        movieInfoLabel.text = row.movieInfo
        
        movieRateLabel.text = String(row.rate)
        
        movieOverviewTitleLabel.text = "줄거리"
        movieOverviewTitleLabel.font = .boldSystemFont(ofSize: 20)
        
        movieOverviewLabel.text = row.overview
        movieOverviewLabel.numberOfLines = 0
    }


}
