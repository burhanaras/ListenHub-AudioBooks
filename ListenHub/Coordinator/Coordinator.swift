//
//  Coordinator.swift
//  ListenHub
//
//  Created by Burhan Aras on 12.09.2021.
//

import Foundation

final class Coordinator{
    public static let shared = Coordinator()
    
    func bookDetailView(for book: Book) -> BookDetailView {
        let viewModel = BookDetailViewModel(book: book)
        return BookDetailView(viewModel: viewModel)
    }
}
