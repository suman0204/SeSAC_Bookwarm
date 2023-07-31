//
//  DetailViewController.swift
//  Bookwarm
//
//  Created by 홍수만 on 2023/07/31.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detailViewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailViewLabel.text = "상세화면"
        detailViewLabel.textAlignment = .center
        detailViewLabel.font = .boldSystemFont(ofSize: 30)
    }
    



}
