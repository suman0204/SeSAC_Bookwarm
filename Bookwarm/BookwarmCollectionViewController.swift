//
//  BookwarmCollectionViewController.swift
//  Bookwarm
//
//  Created by 홍수만 on 2023/07/31.
//

import UIKit

private let reuseIdentifier = "Cell"

class BookwarmCollectionViewController: UICollectionViewController {

    let movieInfo: MovieInfo = MovieInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "수만's 책장"
        
        let nib = UINib(nibName: "BookwarmCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookwarmCollectionViewCell")
        
        setCollectionViewLayout()

    }

    
    func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing + 10)
        
        layout.itemSize = CGSize(width: width / 2, height: width / 2)
        layout.sectionInset = UIEdgeInsets(top: spacing, left: 5 , bottom: spacing, right: 5)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        
        collectionView.collectionViewLayout = layout
    }
    

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieInfo.movieInfoList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let colorSet: [UIColor] = [.red, .blue, .orange, .purple, .brown, .darkGray, .green, .magenta, .systemPink]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookwarmCollectionViewCell", for: indexPath) as? BookwarmCollectionViewCell else{
            
            return UICollectionViewCell()
            
        }
        
        let row = movieInfo.movieInfoList[indexPath.row]
        
        cell.configureCell(row: row)
        
        cell.layer.cornerRadius = 20
        cell.backgroundColor = colorSet.randomElement()
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        
        vc.modalPresentationStyle = .automatic
        
        vc.title = movieInfo.movieInfoList[indexPath.row].title
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func searchBarButtonItemClicked(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {
        
            return
        }
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
}
