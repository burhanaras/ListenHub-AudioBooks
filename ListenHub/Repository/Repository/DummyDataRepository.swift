//
//  DummyDataRepository.swift
//  ListenHub
//
//  Created by Burhan Aras on 12.09.2021.
//

import Foundation

class DummyDataRepository: IRepository {
    func getSimilarContentFor(bookId: String, completion: @escaping (Result<Collection, Error>) -> Void) {
        completion(.success( Collection(id: UUID().uuidString, title: "Similar Books", books: bookz(count: 20))))
    }
    
    
    func getHomeCollections(completion: @escaping (Result<[Collection], Error>) -> Void) {
        completion(.success(collectionz()))
    }
    
//    MARK: - Methods to generate dummy data
    
    private func collectionz() -> [Collection] {
        return [
            Collection(id: UUID().uuidString, title: "Recommended Today", books: bookz(count: 20)),
            Collection(id: UUID().uuidString, title: "The Most Popular", books: bookz(count: 20)),
            Collection(id: UUID().uuidString, title: "The Best Ones", books: bookz(count: 20))
        ]
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
