//
//  SearchViewController.swift
//  Bookwarm
//
//  Created by 홍수만 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var searchViewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "검색화면"
        
        let xmark = UIImage(systemName: "xmark")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        searchViewLabel.text = "검색화면"
        searchViewLabel.textAlignment = .center
        searchViewLabel.font = .boldSystemFont(ofSize: 30)
    }

    @objc
    func closeButtonClicked() {
        
        dismiss(animated: true)
    }

}
