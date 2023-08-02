//
//  DetailViewController.swift
//  Bookwarm
//
//  Created by 홍수만 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var headerBackView: UIView!
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
        movieTitleLabel.font = .boldSystemFont(ofSize: 19)
        movieTitleLabel.textColor = .white
        
        movieInfoLabel.text = row.movieInfo
        movieInfoLabel.textColor = .white
        
        movieRateLabel.text = row.rateText
        
        movieOverviewTitleLabel.text = "줄거리"
        movieOverviewTitleLabel.font = .boldSystemFont(ofSize: 17)
        
        movieOverviewLabel.text = row.overview
        movieOverviewLabel.numberOfLines = 0
    }


}
