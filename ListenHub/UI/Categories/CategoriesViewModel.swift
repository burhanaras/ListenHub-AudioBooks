//
//  CategoriesViewModel.swift
//  ListenHub
//
//  Created by Burhan Aras on 13.09.2021.
//

import Foundation
class CategoriesViewModel: ObservableObject {
    @Published var data: Result<[Category], Error>? = .none
    private let repository: IRepository
    
    init(repository: IRepository) {
        self.repository = repository
        loadData()
    }
    
    func loadData() {
        repository.getCategories { [unowned self] categories in
            self.data = categories
        }
    }
}
