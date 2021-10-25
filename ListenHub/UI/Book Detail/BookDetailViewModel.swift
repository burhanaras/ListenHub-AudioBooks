//
//  BookDetailViewModel.swift
//  ListenHub
//
//  Created by Burhan Aras on 12.09.2021.
//

import Foundation
import Combine

class BookDetailViewModel: ObservableObject {
    @Published private(set) var book : Result<Book, Error>? = .none
    @Published private(set) var similarContent: Result<Collection, Error>? = .none
    @Published private(set) var playbuttonIconAndText: (String, String) = ("headphones", "LISTEN NOW")
    
    private let repository: IRepository
    private let player: Player
    private var cancellables: Set<AnyCancellable> = []
    
    init(repository: IRepository, book: Book, player: Player) {
        self.repository = repository
        self.book = Result<Book, Error>.success(book)
        self.player = player
        downloadSimilarContent(for: book.id)
        self.player.bookPublisher.sink(receiveValue: { [unowned self] playingBook in
            self.playbuttonIconAndText = book.id == playingBook.id ? ("airpodspro", "LISTENING") : ("headphones", "LISTEN NOW")
        })
            .store(in: &cancellables)
    }
    
    func downloadSimilarContent(for bookId: String) {
        repository.getSimilarContentFor(bookId: bookId){ [unowned self] similarBooks in
            self.similarContent = similarBooks
        }
    }
    
}

extension BookDetailViewModel {
    func play() {
        if let book = try? book?.get() {
            player.prepare(book: book, startFrom: 0, playAfterSetup: true)
        }
    }
}
