//
//  HomeViewModel.swift
//  ListenHub
//
//  Created by Burhan Aras on 9.09.2021.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published private(set) var data: Result<[Collection], Error>? = .none
    private let repository: IRepository
    
    init(repository: IRepository) {
        self.repository = repository
        loadData()
    }
    
    private func loadData() {
        repository.getHomeCollections{ [unowned self] collections in
            self.data = collections
        }
    }
}

let dummyBook = Book(id: "12345", title: "Animal Farm A Very Very Very Long Name Here", author: Author(id: "0", name: "George Orwell"), imageURL: URL(string: "https://m.media-amazon.com/images/I/612oBD9OSjL._SL320_.jpg")!, description: "George Orwell depicts a gray, totalitarian world dominated by Big Brother and its vast network of agents, including the Thought Police - a world in which news is manufactured according to the authorities' will and people live tepid lives by rote.")
