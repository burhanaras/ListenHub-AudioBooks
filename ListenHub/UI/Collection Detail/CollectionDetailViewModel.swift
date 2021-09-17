//
//  CollectionDetailViewModel.swift
//  ListenHub
//
//  Created by Burhan Aras on 14.09.2021.
//

import Foundation
class CollectionDetailViewModel: ObservableObject {
    @Published private(set) var data: Result<Collection, Error>? = .none
    
    private let repository: IRepository
    private var category: Category? = nil
    private var language: Language? = nil
    
    init(repository: IRepository, category: Category?, language: Language?) {
        self.repository = repository
        self.category = category
        self.language = language
        fetchData()
    }
    
    func fetchData() {
        if let category = category {
            fetchCategoryDetail(categoryId: category.id)
        } else if let language = language {
            self.fetchLanguageDetail(languageId: language.id)
        }
    }

}

extension CollectionDetailViewModel {
    func fetchCategoryDetail(categoryId: String) {
        self.repository.getCategoryDetail { [unowned self] result in
            switch result {
            case let .success(books):
                if let category = category {
                    self.data = .success(Collection(id: category.id, title: category.name, books: books))
                }
            case  let .failure(error):
                self.data = .failure(error)
            }
        }
    }
    
    func fetchLanguageDetail(languageId: String) {
        self.repository.getLanguageDetail { [unowned self] result in
            switch result {
            case let .success(books):
                if let language = language {
                    self.data = .success(Collection(id: language.id, title: "\(language.emoji) \(language.name)", books: books))
                }
            case  let .failure(error):
                self.data = .failure(error)
            }
        }
    }
}
