//
//  CollectionDetailView.swift
//  ListenHub
//
//  Created by Burhan Aras on 14.09.2021.
//

import SwiftUI

struct CollectionDetailView: View {
    @ObservedObject var viewModel: CollectionDetailViewModel

    
    var body: some View {
        VStack{
            switch viewModel.data {
            case let .success(collection):
                collectionDetail(collection: collection)
            case let .failure(error):
                ErrorView(error: error)
            case .none:
                LoadingView()
            }
        }
    }
}

extension CollectionDetailView {
    func collectionDetail(collection: Collection) -> some View {
        VStack{
            BookGridView(books: collection.books)
        }
        .navigationBarTitle(collection.title)
    }
}

struct CollectionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CollectionDetailView(
                viewModel: CollectionDetailViewModel(
                    repository: DummyDataRepository(),
                    category: Category(id: "1", name: "Science Fiction",
                                   imageURL: dummyBook.imageURL, books: [dummyBook]), language: nil)
            )
            
            CollectionDetailView(viewModel: CollectionDetailViewModel(repository: DummyDataRepository(), category: nil, language: Language(id: "1", name: "Kurdish", originalName: "Kurdi", flag: "🇹🇯", emoji: "🇹🇯", books: [dummyBook])))
        }
    }
}
