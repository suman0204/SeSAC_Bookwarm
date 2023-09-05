//
//  SearchBookViewController.swift
//  Bookwarm
//
//  Created by 홍수만 on 2023/08/09.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import RealmSwift

struct Book {
    let title: String
    let contents: String
    let author: String
    let salePrice: Int
    let thumbnail: String
    
    var priceText: String {
        return "판매가: \(salePrice)원"
    }

}

class SearchBookViewController: UIViewController {
    
    var bookList: [Book] = []
    
    var searchList:[Book] = []
    {
        didSet{
            searchResultTableView.reloadData()
        }
    }
    
    var page = 1
    var isEnd = false
    
    let searchBar = UISearchBar()

    @IBOutlet var searchResultTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    func callRequest(query: String, page: Int) {
        //한글 인코딩
        let text = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = "https://dapi.kakao.com/v3/search/book?query=\(text)&size=10&page=\(page)"
        let header: HTTPHeaders = ["Authorization" : "KakaoAK \(APIKey.kakao)"]
        
        AF.request(url, method: .get, headers: header).validate(statusCode: 200...500).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                print("JSON: \(json)")
                
                let statusCode = response.response?.statusCode ?? 500
                
                if statusCode == 200 {
                    
                    self.isEnd = json["meta"]["is_end"].boolValue
                    
                    for item in json["documents"].arrayValue {
                        let title = item["title"].stringValue
                        let contents = item["contents"].stringValue
                        let authors = item["authors"][0].stringValue
                        let salePrice = item["sale_price"].intValue
                        let thumbnail = item["thumbnail"].stringValue
                        
                        let data = Book(title: title, contents: contents, author: authors, salePrice: salePrice, thumbnail: thumbnail)
                        
                        self.bookList.append(data)
                    }
                    
                    self.searchResultTableView.reloadData()
                } else {
                    print("문제가 발생했여요, 잠시 후 다시 시도해주세요!")
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc
    func closeButtonClicked() {
        dismiss(animated: true)
    }

}

extension SearchBookViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchResultTableView.dequeueReusableCell(withIdentifier: "AroundTableViewCell") as! AroundTableViewCell
        
        let row = bookList[indexPath.row]
        
        cell.configureBookCell(row: row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if bookList.count - 1 == indexPath.row && page < 15 && isEnd == false {
                page += 1
                callRequest(query: searchBar.text!, page: page)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let row = bookList[indexPath.row]
        
        let realm = try! Realm()
        
        let task = BookStore(bookTitle: row.title, bookThumbnail: row.thumbnail, bookContents: row.contents, bookAuthor: row.author,  bookPrice: row.salePrice, bookReview: nil)
        
        try! realm.write {
            realm.add(task)
            print("Realm Add Succed")
            showAlertMessage(title: "저장", message: "선택한 책이 저장되었습니다.")
        }
        

        
        DispatchQueue.global().async {
            if let url = URL(string: row.thumbnail), let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.saveImageToDocument(fileName: "book_\(task._id).jpg", image: UIImage(data: data) ?? UIImage(systemName: "stat")!)
                }
            }
        }
        
        
    }
    
    //alert 함수
    func showAlertMessage(title: String, message: String, button: String = "확인", handler: (() -> ())? = nil ) { //매개변수 기본값
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: button, style: .default) { _ in
            handler?()
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
}

extension SearchBookViewController: UISearchBarDelegate {
    
    // searchBar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        bookList.removeAll()
        searchBar.text = ""
        searchResultTableView.reloadData()
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        page = 1
        
        bookList.removeAll()

        guard let query = searchBar.text else {
            return
        }
        
        callRequest(query: query, page: page)
        
    }
//    API 통신시 실시간 검색을 하면 너무 많은 요청과 응답이 발생
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        searchList.removeAll()
//
//        for book in bookList{
//            if book.title.contains(searchBar.text!) {
//                searchList.append(book)
//            }
//        }
//
//        searchResultTableView.reloadData()
//    }
}
