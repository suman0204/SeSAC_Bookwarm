//
//  AroundTableViewCell.swift
//  Bookwarm
//
//  Created by 홍수만 on 2023/08/02.
//

import UIKit

class AroundTableViewCell: UITableViewCell {

    @IBOutlet var posterImage: UIImageView!
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var rateLabel: UILabel!
    
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
        infoLabel.text = row.movieInfo
        rateLabel.text = row.rateText
    }
    
}
