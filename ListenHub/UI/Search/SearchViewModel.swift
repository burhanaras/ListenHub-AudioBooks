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
            searchTimer?.invalidate()
            if query.isEmpty {
                self.status = SearchViewState.showHints(hints)
            } else {
                if query.count >= 3 {
                    searchTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(search), userInfo: nil, repeats: false)
                }
            }
        }
    }
    
    @Published private(set) var status: SearchViewState = SearchViewState.loading
    private var hints = [String]()
    private var searchTimer: Timer?
    
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
    
    @objc func search() {
        self.status = SearchViewState.searching
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.repository.search(for: self.query) { [unowned self] result in
                switch self.status {
                case SearchViewState.searching: break
                default: return
                }
                
                switch result {
                case let .success(books):
                    self.status = SearchViewState.results(books)
                case let .failure(error):
                    self.status = SearchViewState.failure(error)
                }
            }
        }
    }
    
    func cancel(){
        searchTimer?.invalidate()
    }
}
