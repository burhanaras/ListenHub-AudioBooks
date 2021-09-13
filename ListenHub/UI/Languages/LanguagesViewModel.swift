//
//  LanguagesViewModel.swift
//  ListenHub
//
//  Created by Burhan Aras on 12.09.2021.
//

import Foundation

class LanguagesViewModel: ObservableObject {
    @Published private(set) var data: Result<[Language], Error>? = .none
    
    private let repository = DummyDataRepository()
    
    init() {
        fetchLanguages()
    }
    
    private func fetchLanguages() {
        self.repository.getLanguages { [unowned self] languages in
            self.data = languages
        }
    }
}
