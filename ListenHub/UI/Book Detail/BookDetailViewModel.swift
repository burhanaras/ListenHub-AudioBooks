//
//  BookDetailViewModel.swift
//  ListenHub
//
//  Created by Burhan Aras on 12.09.2021.
//

import Foundation

class BookDetailViewModel: ObservableObject {
    @Published var book : Result<Book, Error>? = .none
    @Published var similarContent: Result<Collection, Error>? = .none
    
    private let repository: IRepository = DummyDataRepository()
    
    init(book: Book) {
        self.book = Result<Book, Error>.success(book)
        downloadSimilarContent(for: book.id)
    }
    
    func downloadSimilarContent(for bookId: String) {
        repository.getSimilarContentFor(bookId: bookId){ [unowned self] similarBooks in
            self.similarContent = similarBooks
        }
    }

}
