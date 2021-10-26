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
    @Published private(set) var playbuttonText: String = "LISTEN NOW"
    @Published private(set) var showEqualizer: Bool = false
    
    private let repository: IRepository
    private let player: Player
    private var cancellables: Set<AnyCancellable> = []
    
    init(repository: IRepository, book: Book, player: Player) {
        self.repository = repository
        self.book = Result<Book, Error>.success(book)
        self.player = player
        downloadSimilarContent(for: book.id)
        self.player.bookPublisher.sink(receiveValue: { [unowned self] playingBook in
            self.playbuttonText = book.id == playingBook.id ? "LISTENING" : "LISTEN NOW"
            self.showEqualizer = book.id == playingBook.id
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
