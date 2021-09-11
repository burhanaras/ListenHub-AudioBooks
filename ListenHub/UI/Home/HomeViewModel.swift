//
//  HomeViewModel.swift
//  ListenHub
//
//  Created by Burhan Aras on 9.09.2021.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var data: Result<[Collection], Error>? = .none
    
    init() {
        loadData()
    }
    
    private func loadData() {
        let collectionz = [
            Collection(id: UUID().uuidString, title: "Recommended Today", books: bookz(count: 20)),
            Collection(id: UUID().uuidString, title: "The Most Popular", books: bookz(count: 20)),
            Collection(id: UUID().uuidString, title: "The Best Ones", books: bookz(count: 20))
        ]
        
        self.data = .success(collectionz)
    }
    
    private func bookz(count: Int) -> [Book] {
        var books = [Book]()
        (0..<20).forEach{ index in
            let book = Book(id: "\(index)", title: "Book \(index)", author: Author(id: "0", name: "George Orwell"), imageURL: URL(string: "https://m.media-amazon.com/images/I/612oBD9OSjL._SL320_.jpg")!)
            books.append(book)
        }
        return books
    }
}

let dummyBook = Book(id: "12345", title: "Animal Farm", author: Author(id: "0", name: "George Orwell"), imageURL: URL(string: "https://m.media-amazon.com/images/I/612oBD9OSjL._SL320_.jpg")!)
