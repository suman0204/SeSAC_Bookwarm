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
    @Persisted var bookPrice: Int
    
    convenience init(bookTitle: String, bookThumbnail: String, bookPrice: Int) {
        self.init()
        self.bookTitle = bookTitle
        self.bookThumbnail = bookThumbnail
        self.bookPrice = bookPrice
        
    }
}
