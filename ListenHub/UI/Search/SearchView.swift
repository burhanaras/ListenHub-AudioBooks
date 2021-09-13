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
                
                switch viewModel.status {
                case .loading:
                    LoadingView()
                case let .showHints(hints):
                    hintsList(hints: hints)
                case .searching:
                    ProgressView()
                case let .results(books):
                    BookListView(books: books)
                case let .failure(error):
                    ErrorView(error: error)
                }
                Spacer()
            }
            .navigationBarTitle("Search")
        }
    }
}

extension SearchView {
    func searchBar() -> some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass").foregroundColor(.secondary)
                TextField("Enter name or number", text: $viewModel.query, onEditingChanged: { isEditing in
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
            .background(Color.black.opacity(0.2))
            .cornerRadius(8)
            
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
            List{
                ForEach(hints, id: \.self){ hint in
                    Text(hint).onTapGesture {
                        viewModel.query = hint
                    }
                }
            }
            Spacer()
            HStack{Spacer()} 
        }
    }
}

struct BookListView: View {
    let books: [Book]
    let columns = [GridItem(.adaptive(minimum: isIPad ? 220 : 140, maximum: .infinity))]
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns, alignment: .center, spacing: 8, pinnedViews: [], content: {
                ForEach(books) { book in
                    BookView(book: book)
                }
            })
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
