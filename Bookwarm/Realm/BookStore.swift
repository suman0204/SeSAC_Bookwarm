//
//  BookStore.swift
//  Bookwarm
//
//  Created by 홍수만 on 2023/09/04.
//

import Foundation
import RealmSwift

class BookStore: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var bookTitle: String
    @Persisted var bookThumbnail: String
    @Persisted var bookContents: String
    @Persisted var bookAuthor: String
    @Persisted var bookPrice: Int
    @Persisted var bookReview: String?
    
    convenience init(bookTitle: String, bookThumbnail: String, bookContents: String, bookAuthor: String, bookPrice: Int, bookReview: String?) {
        self.init()
        self.bookTitle = bookTitle
        self.bookThumbnail = bookThumbnail
        self.bookContents = bookContents
        self.bookAuthor = bookAuthor
        self.bookPrice = bookPrice
        self.bookReview = bookReview
        
    }
}
