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
        .navigationViewStyle(StackNavigationViewStyle())
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
    let bookDimensions: (CGFloat, CGFloat) = (UIDevice.current.model == "iPad") ? (CGFloat(220), CGFloat(330)) : (CGFloat(140), CGFloat(220))
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8){
            Text(collection.title)
                .font(.headline)
                .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false){
                HStack (spacing: 12){
                    ForEach(collection.books){ book in
                        NavigationLink(
                            destination: Coordinator.shared.bookDetailView(for: book),
                            label: {
                                VStack (alignment: .leading){
                                    NetworkImage(imageURL: book.imageURL)
                                    .aspectRatio(1, contentMode: .fit)
                                    .frame(width: bookDimensions.0, height: bookDimensions.0, alignment: .center)
                                    .cornerRadius(8)
                                        .shadow(radius: 8)
                                    
                                    Text(book.title)
                                        .font(.subheadline).bold()
                                        .foregroundColor(.primary)
                                        .padding(.bottom, 2)
                                    
                                    Text(book.author.name)
                                        .font(.subheadline).bold()
                                        .foregroundColor(.primary)
                                        .opacity(0.6)
                                    
                                }
                                .frame(width: bookDimensions.0, height: bookDimensions.1, alignment: .leading)

                            })
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
