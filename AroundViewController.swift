//
//  AroundViewController.swift
//  Bookwarm
//
//  Created by 홍수만 on 2023/08/02.
//

import UIKit

class AroundViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    var movieInfo: MovieInfo = MovieInfo() {
        didSet {
            headerCollectionView.reloadData()
        }
    }
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerCollectionView: UICollectionView!
    @IBOutlet var headerViewTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        headerCollectionView.delegate = self
        headerCollectionView.dataSource = self
        
        let nib = UINib(nibName: "AroundCollectionViewCell", bundle: nil)
        headerCollectionView.register(nib, forCellWithReuseIdentifier: "AroundCollectionViewCell")
        
        title = "둘러보기"
        
        configureHeaderView()
        configureHeaderCollectionViewLayout()

    }
    
    func configureHeaderView() {
        headerViewTitle.text = "최근 본 작품"
        headerViewTitle.font = .boldSystemFont(ofSize: 17)
    }
    
    func configureHeaderCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 160)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        headerCollectionView.collectionViewLayout = layout
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieInfo.movieInfoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = headerCollectionView.dequeueReusableCell(withReuseIdentifier: "AroundCollectionViewCell", for: indexPath) as! AroundCollectionViewCell
        
        cell.posterImage.image = movieInfo.movieInfoList[indexPath.row].posterImage
        
        return cell
    }
    
}
