//
//  AroundTableViewCell.swift
//  Bookwarm
//
//  Created by 홍수만 on 2023/08/02.
//

import UIKit
import Kingfisher

class AroundTableViewCell: UITableViewCell {

    @IBOutlet var posterImage: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentsLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var salePriceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(row: Movie) {
        posterImage.image = row.posterImage
        titleLabel.text = row.title
        contentsLabel.text = row.movieInfo
        infoLabel.text = row.rateText
    }
    
    func configureBookCell(row: Book) {
        titleLabel.text = row.title
        contentsLabel.text = row.contents
        infoLabel.text = row.authors
        
        if let url = URL(string: row.thumbnail) {
            posterImage.kf.setImage(with: url)
        }
        
        salePriceLabel.text = row.priceText
    }
    
}
