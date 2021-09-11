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
        var books = [Book]()
        (0..<20).forEach{ index in
            let book = Book(id: "\(index)", title: "Book \(index)", author: Author(id: "0", name: "George Orwell"), imageURL: URL(string: "https://m.media-amazon.com/images/I/612oBD9OSjL._SL320_.jpg")!)
            books.append(book)
        }
        let collection = Collection(id: UUID().uuidString, title: "The Most Popular", books: books)
        
        self.data = .success([collection])
    }
}
