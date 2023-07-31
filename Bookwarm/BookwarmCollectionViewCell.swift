//
//  BookwarmCollectionViewCell.swift
//  Bookwarm
//
//  Created by 홍수만 on 2023/07/31.
//

import UIKit

class BookwarmCollectionViewCell: UICollectionViewCell {

    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieRate: UILabel!
    @IBOutlet var moviePoster: UIImageView!
    
    func configureCell(row: Movie) {
        movieTitle.text = row.title
        movieTitle.textColor = .white
        movieTitle.font = .boldSystemFont(ofSize: 17)
        
        movieRate.text = String(row.rate)
        movieRate.textColor = .white
        
        moviePoster.image = UIImage(named: row.title)
        
    }
    

}
