//
//  SearchViewController.swift
//  Bookwarm
//
//  Created by 홍수만 on 2023/07/31.
//

import UIKit

class SearchViewController: UIViewController {

    
    var movieInfo: MovieInfo = MovieInfo()
//    {
//        didSet {
//            searchResultTableView.reloadData()
//        }
//    }
    
    var searchList:[Movie] = [] {
        didSet{
            searchResultTableView.reloadData()
        }
    }
    
    let searchBar = UISearchBar()
    
    @IBOutlet var searchResultTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        title = "검색화면"
        searchBar.delegate = self
        searchBar.placeholder = "검색어를 입력해주세요"
        searchBar.showsCancelButton = true
        
        //검색 결과 테이블 뷰 셀
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        navigationItem.titleView = searchBar
        
        let xmark = UIImage(systemName: "xmark")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: xmark, style: .plain, target: self, action: #selector(closeButtonClicked))
        
        navigationItem.leftBarButtonItem?.tintColor = .black
        
        let nib = UINib(nibName: "AroundTableViewCell", bundle: nil)
        searchResultTableView.register(nib, forCellReuseIdentifier: "AroundTableViewCell")
        
    }

    @objc
    func closeButtonClicked() {
        
        dismiss(animated: true)
    }

}


extension SearchViewController: UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource{
    
    // searchResultTableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = searchResultTableView.dequeueReusableCell(withIdentifier: "AroundTableViewCell") as! AroundTableViewCell
        
        let row = searchList[indexPath.row]
        
        cell.configureCell(row: row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
    
    // searchBar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchList.removeAll()
        searchBar.text = ""
        searchResultTableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchList.removeAll()
        
        for movie in movieInfo.movieInfoList {
            if movie.title.contains(searchBar.text!) {
                searchList.append(movie)
            }
        }
        
        searchResultTableView.reloadData()
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        searchList.removeAll()
        
        for movie in movieInfo.movieInfoList {
            if movie.title.contains(searchBar.text!) {
                searchList.append(movie)
            }
        }
        
        searchResultTableView.reloadData()
    }
}


