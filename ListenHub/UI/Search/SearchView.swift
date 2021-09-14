//
//  SearchView.swift
//  ListenHub
//
//  Created by Burhan Aras on 13.09.2021.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @State var showCancelButton: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                searchBar()
                    .padding(.bottom)
                
                switch viewModel.status {
                case .loading:
                    LoadingView()
                case let .showHints(hints):
                    hintsList(hints: hints)
                case .searching:
                    ProgressView()
                case let .results(books):
                    BookGridView(books: books)
                case let .failure(error):
                    ErrorView(error: error)
                }
                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension SearchView {
    func searchBar() -> some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(.secondary)
                TextField("Search..", text: $viewModel.query, onEditingChanged: { isEditing in
                    self.showCancelButton = true
                })
                
                
                Button(action: {
                    viewModel.query = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .opacity(viewModel.query == "" ? 0 : 1)
                }
            }
            .padding(8)
            .padding(.horizontal)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding(.horizontal)
            
            if self.showCancelButton  {
                Button("Cancel") {
                    viewModel.query = ""
                    self.showCancelButton = false
                }
            }
        }
        .padding([.leading, .trailing,.top])
    }
    
    func hintsList(hints: [String]) -> some View {
        VStack {
            ForEach(hints, id: \.self){ hint in
                Text(hint)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .foregroundColor(.accentColor)
                    .onTapGesture {
                        viewModel.query = hint
                    }
                Divider().padding(.horizontal)
            }
        }
    }
}

struct BookGridView: View {
    let books: [Book]
    let columns = [GridItem(.adaptive(minimum: isIPad ? 220 : 140, maximum: .infinity))]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, alignment: .center, spacing: 24, pinnedViews: [], content: {
                ForEach(books) { book in
                    AdaptiveBookView(book: book)
                }
            })
            .padding(.horizontal)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: SearchViewModel(repository: DummyDataRepository()))
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro Max"))
        
        SearchView(viewModel: SearchViewModel(repository: DummyDataRepository()))
            .previewDevice(PreviewDevice(rawValue: "iPad Pro"))
    }
}
