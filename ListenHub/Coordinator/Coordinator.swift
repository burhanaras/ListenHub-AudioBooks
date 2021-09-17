//
//  Coordinator.swift
//  ListenHub
//
//  Created by Burhan Aras on 12.09.2021.
//

import Foundation

final class Coordinator{
    public static let shared = Coordinator()
    private let repository: IRepository = DummyDataRepository()
    
    func bookDetailView(for book: Book) -> BookDetailView {
        let viewModel = BookDetailViewModel(book: book)
        return BookDetailView(viewModel: viewModel)
    }
    
    func collectionDetail(for language: Language) -> CollectionDetailView {
        let viewModel = CollectionDetailViewModel(repository: repository, category: nil, language: language)
        return CollectionDetailView(viewModel: viewModel)
    }
    
    func collectionDetail(for category: Category) -> CollectionDetailView {
        let viewModel = CollectionDetailViewModel(repository: repository, category: category, language: nil)
        return CollectionDetailView(viewModel: viewModel)
    }
}
