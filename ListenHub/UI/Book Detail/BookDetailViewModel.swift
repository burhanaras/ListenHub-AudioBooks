//
//  BookDetailViewModel.swift
//  ListenHub
//
//  Created by Burhan Aras on 12.09.2021.
//

import Foundation

class BookDetailViewModel: ObservableObject {
    @Published private(set) var book : Result<Book, Error>? = .none
    @Published private(set) var similarContent: Result<Collection, Error>? = .none
    @Published private(set) var isPlaying: Bool = false
    
    private let repository: IRepository = DummyDataRepository()
    let player: Player
    
    init(book: Book, player: Player) {
        self.book = Result<Book, Error>.success(book)
        self.player = player
        downloadSimilarContent(for: book.id)
    }
    
    func downloadSimilarContent(for bookId: String) {
        repository.getSimilarContentFor(bookId: bookId){ [unowned self] similarBooks in
            self.similarContent = similarBooks
        }
    }
    
}

extension BookDetailViewModel {
    func play() {
        player.prepare(book: try! book?.get() as! Book)
    }
}
