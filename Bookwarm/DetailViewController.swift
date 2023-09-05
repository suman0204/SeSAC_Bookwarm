//
//  DetailViewController.swift
//  Bookwarm
//
//  Created by 홍수만 on 2023/07/31.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController {
    
    var data: BookStore?
    var tasks: Results<BookStore>!
    let realm = try! Realm()

    
    @IBOutlet var headerBackView: UIView!
    @IBOutlet var moviePosterImage: UIImageView!

    @IBOutlet var movieTitleLabel: UILabel!
    @IBOutlet var movieInfoLabel: UILabel!
    @IBOutlet var movieRateLabel: UILabel!
    @IBOutlet var movieOverviewTitleLabel: UILabel!
    @IBOutlet var movieOverviewLabel: UILabel!
    
    @IBOutlet var memoTextView: UITextView!
    
    let placeholderText: String = "감상평을 입력해주세요."

    var row: Movie = Movie(title: "정보없음", releaseDate: "정보없음", runtime: 0, overview: "정보없음", rate: 0.0)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        memoTextView.text = contents
//
        memoTextView.text = placeholderText
        memoTextView.textColor = .lightGray
        
        memoTextView.delegate = self

        tasks = realm.objects(BookStore.self)
        
//        configureDetailView(row: row)
        guard let data = data else {return}
        configureBookDetailView(row: data)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "수정", style: .plain, target: self, action: #selector(editButtonClicked))
        
        print("Viewdidload")
        if memoTextView.text != data.bookReview {
            memoTextView.text = data.bookReview
            memoTextView.textColor = .black
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewwillappear")
        print(memoTextView.text)
    }
    
    //수정 버튼 클릭시 Update
    @objc func editButtonClicked() {
        guard let data = data else {return}
        let item = BookStore(value: ["_id": data._id,"bookTitle": data.bookTitle, "bookThumbnail": data.bookThumbnail,"bookContents": data.bookContents, "bookAuthor": data.bookAuthor, "bookPrice": data.bookPrice, "bookReview": memoTextView.text])
        
        do {
            try realm.write {
                realm.add(item, update: .modified)
            }
        } catch {
            print(error)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    
    //검색 후 저장된 책 정보
    func configureBookDetailView(row: BookStore) {
        
        title = row.bookTitle
        
        moviePosterImage.image = loadImageFromDocument(fileName: "book_\(row._id).jpg")
        
        movieTitleLabel.text = row.bookTitle
        movieTitleLabel.font = .boldSystemFont(ofSize: 19)
        movieTitleLabel.textColor = .white
        
        movieInfoLabel.text = row.bookAuthor
        movieInfoLabel.textColor = .white
        
        movieRateLabel.text = "\(row.bookPrice)"
        
        movieOverviewTitleLabel.text = "줄거리"
        movieOverviewTitleLabel.font = .boldSystemFont(ofSize: 17)
        
        movieOverviewLabel.text = row.bookContents
        movieOverviewLabel.numberOfLines = 0
    }
    
    func configureDetailView(row: Movie) {

        title = row.title

        moviePosterImage.image = UIImage(named: row.title)

        movieTitleLabel.text = row.title
        movieTitleLabel.font = .boldSystemFont(ofSize: 19)
        movieTitleLabel.textColor = .white

        movieInfoLabel.text = row.movieInfo
        movieInfoLabel.textColor = .white

        movieRateLabel.text = row.rateText

        movieOverviewTitleLabel.text = "줄거리"
        movieOverviewTitleLabel.font = .boldSystemFont(ofSize: 17)

        movieOverviewLabel.text = row.overview
        movieOverviewLabel.numberOfLines = 0
    }


}

extension DetailViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        print(#function)
        if textView.text == placeholderText {
            textView.text = nil
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        print(#function)
        if textView.text.isEmpty {
            textView.text = placeholderText
            textView.textColor = .lightGray
        }
    }
    
}
