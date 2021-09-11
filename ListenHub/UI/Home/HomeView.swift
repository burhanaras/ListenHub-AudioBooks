//
//  HomeView.swift
//  ListenHub
//
//  Created by Burhan Aras on 9.09.2021.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel
    
    init(viewModel: HomeViewModel) {
        _viewModel = ObservedObject(initialValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            VStack{
                switch viewModel.data {
                case let .success(collections):
                    collectionList(collections: collections)
                case let .failure(error):
                   ErrorView(error: error)
                case .none:
                   LoadingView()
                }
            }
            .navigationBarTitle("Home")
        }
    }
}

extension HomeView {
    func collectionList(collections: [Collection]) -> some View {
        ScrollView(.vertical, showsIndicators: false){
            ForEach(collections){ collection in
                ShelfView(collection: collection)
            }
        }
    }
}

struct ShelfView: View {
    let collection: Collection
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8){
            Text(collection.title)
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack{
                    ForEach(collection.books){ book in
                        VStack (alignment: .leading){
                            NetworkImage(imageURL: book.imageURL)
                            .aspectRatio(1, contentMode: .fit)
                            .cornerRadius(8)
                            
                            Text(book.title).font(.subheadline).bold()
                            Text(book.author.name)
                                .opacity(0.6)
                            
                        }
                        .frame(width: 160, height: 200, alignment: .leading)
                    }
                }
                .padding([.leading, .bottom])
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView(viewModel: HomeViewModel())
            ShelfView(collection: Collection(id: "", title: "Newest Books", books: [dummyBook]))
                .previewLayout(.sizeThatFits)
        }
    }
}
