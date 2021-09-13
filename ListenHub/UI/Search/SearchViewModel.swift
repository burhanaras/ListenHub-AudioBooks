//
//  SearchViewModel.swift
//  ListenHub
//
//  Created by Burhan Aras on 13.09.2021.
//

import Foundation

enum SearchViewState {
    case loading
    case showHints([String])
    case searching
    case results([Book])
    case failure(Error)
}

class SearchViewModel: ObservableObject {
    @Published var query: String = "" {
        didSet {
            if query.isEmpty {
                self.status = SearchViewState.showHints(hints)
            } else {
                search(for: query)
            }
        }
    }
    
    @Published private(set) var status: SearchViewState = SearchViewState.loading
    private var hints = [String]()
    
    private let repository: IRepository
    
    init(repository: IRepository) {
        self.repository = repository
        downloadSearchHints()
    }
    
    func downloadSearchHints() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.repository.getSearchHints {[unowned self] result in
                switch result {
                case let .success(hints):
                    self.status = SearchViewState.showHints(hints)
                    self.hints = hints
                case let .failure(error):
                    self.status = SearchViewState.failure(error)
                }
            }
        }
    }
    
    func search(for query: String) {
        self.status = SearchViewState.searching
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.repository.search(for: query) { [unowned self] result in
                switch result {
                case let .success(books):
                    self.status = SearchViewState.results(books)
                case let .failure(error):
                    self.status = SearchViewState.failure(error)
                }
            }
        }
    }
}
