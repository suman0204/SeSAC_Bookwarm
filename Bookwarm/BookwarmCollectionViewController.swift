//
//  BookwarmCollectionViewController.swift
//  Bookwarm
//
//  Created by 홍수만 on 2023/07/31.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class BookwarmCollectionViewController: UICollectionViewController {

    var movieInfo: MovieInfo = MovieInfo() {
        didSet {
            collectionView.reloadData()
        }
    }
    
//    var todo = TodoCSInformation() {
//        didSet { // 변수가 달라짐을 감지!
//            print("DidSet이 뭘까..")
//            tableView.reloadData()
//        }
//    }
    
    // 검색한 책 저장된 값 불러오기
    var tasks: Results<BookStore>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "수만's 책장"
        
        let nib = UINib(nibName: "BookwarmCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "BookwarmCollectionViewCell")
        
        setCollectionViewLayout()
        
        //Realm Read하기
        let realm = try! Realm()
        tasks = realm.objects(BookStore.self)
        
        print(realm.configuration.fileURL)

    }
    
    //뷰가 다시 보일 때 컬렉션 뷰 갱신
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        collectionView.reloadData()
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
//        return movieInfo.movieInfoList.count
        return tasks.count // 저장된 책의 갯수
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let colorSet: [UIColor] = [.red, .blue, .orange, .purple, .brown, .darkGray, .green, .magenta, .systemPink]
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BookwarmCollectionViewCell", for: indexPath) as? BookwarmCollectionViewCell else{
            
            return UICollectionViewCell()
            
        }
        
//        let row = movieInfo.movieInfoList[indexPath.row]
        let row = tasks[indexPath.row]
        
//        cell.configureCell(row: row)
        cell.configureBookCell(row: row) // 저장된 책 내용 configure
        
        cell.layer.cornerRadius = 20
        cell.backgroundColor = colorSet.randomElement()
        
        cell.favoriteButton.tag = indexPath.row
        cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc func favoriteButtonClicked(_ sender: UIButton) {
        movieInfo.movieInfoList[sender.tag].isFavorite.toggle()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        guard let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        
        vc.modalPresentationStyle = .automatic
        
        vc.title = movieInfo.movieInfoList[indexPath.row].title
        
        let row = movieInfo.movieInfoList[indexPath.row]
        vc.row = row
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func searchBarButtonItemClicked(_ sender: UIBarButtonItem) {
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = sb.instantiateViewController(withIdentifier: "SearchBookViewController") as? SearchBookViewController else {
        
            return
        }
        
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true)
    }
    
}
