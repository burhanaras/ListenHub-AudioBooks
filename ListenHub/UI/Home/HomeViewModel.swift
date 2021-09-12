//
//  HomeViewModel.swift
//  ListenHub
//
//  Created by Burhan Aras on 9.09.2021.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var data: Result<[Collection], Error>? = .none
    
    private let repository: IRepository = DummyDataRepository()
    
    init() {
        loadData()
    }
    
    private func loadData() {
        repository.getHomeCollections{ [unowned self] collections in
            self.data = collections
        }
    }
}

let dummyBook = Book(id: "12345", title: "Animal Farm", author: Author(id: "0", name: "George Orwell"), imageURL: URL(string: "https://m.media-amazon.com/images/I/612oBD9OSjL._SL320_.jpg")!)
