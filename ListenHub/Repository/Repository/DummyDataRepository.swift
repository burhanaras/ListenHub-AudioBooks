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
    
    func getLanguages(completion: @escaping (Result<[Language], Error>) -> Void) {
        completion(.success(languagez(count: 40)))
    }
    
    func getCategories(completion: @escaping (Result<[Category], Error>) -> Void) {
        completion(.success(categoriez(count: 40)))
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
            let book = Book(id: "\(index)", title: "Book \(index) A Very Very Very Long Name Goes Here", author: Author(id: "0", name: "George Orwell"), imageURL: URL(string: "https://m.media-amazon.com/images/I/612oBD9OSjL._SL320_.jpg")!, description: """
                George Orwell depicts a gray, totalitarian world dominated by Big Brother and its vast network of agents, including the Thought Police - a world in which news is manufactured according to the authorities' will and people live tepid lives by rote.
                
                Winston Smith, a hero with no heroic qualities, longs only for truth and decency. But living in a social system in which privacy does not exist and where those with unorthodox ideas are brainwashed or put to death, he knows there is no hope for him.
                
                The year 1984 has come and gone, yet George Orwell's nightmare vision of the world we were becoming in 1949 is still the great modern classic portrait of a negative Utopia.
                
                ©1949 Harcourt Brace and Company, renewed 1977 Sonia Brownell Orwell (P)2007 Blackstone Audio Inc.
                """)
            books.append(book)
        }
        return books
    }
    
    private func languagez(count: Int) -> [Language] {
        var data = [Language]()
        
        (0 ..< count).forEach{ index in
            let language = Language(id: "\(index)", name: "Language \(index)", originalName: "English", flag: "🇺🇸", emoji: "🇺🇸", books: bookz(count: 15))
            data.append(language)
        }
        return data
    }
    
    private func categoriez(count: Int) -> [Category] {
        var data = [Category]()
        
        (0 ..< count).forEach { index in
           let category = Category(id: "\(index)", name: "Category \(index)", imageURL: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/System-users.svg/1200px-System-users.svg.png")!, books: bookz(count: 30))
            data.append(category)
        }
        
        return data
    }
    
}
