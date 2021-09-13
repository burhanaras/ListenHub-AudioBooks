//
//  CategoriesView.swift
//  ListenHub
//
//  Created by Burhan Aras on 13.09.2021.
//

import SwiftUI

struct CategoriesView: View {
    @ObservedObject var viewModel: CategoriesViewModel
    
    var body: some View {
        NavigationView {
            switch viewModel.data {
            case let .success(categories):
                categoriesList(categories: categories)
            case let .failure(error):
                ErrorView(error: error)
            case .none:
                LoadingView()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension CategoriesView {
    var columns: [GridItem] {
        let column = GridItem(.flexible(minimum: 0, maximum: .infinity))
        return isIPad ? [column, column] : [column]
    }
    func categoriesList(categories: [Category]) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Divider()
                LazyVGrid(columns: columns, alignment: .leading, spacing: 8, pinnedViews: [], content: {
                    ForEach(categories){ category in
                        CategoryView(category: category)
                    }
                })
            }
        }
        .navigationBarTitle("Categories")
    }
}

struct CategoryView: View {
    let category: Category
    var body: some View {
        VStack {
            NavigationLink(
                destination: Text("Categories Detail"),
                label: {
                    HStack {
                        NetworkImage(imageURL: category.imageURL)
                            .frame(width: 60, height: 60)
                        Text(category.name)
                            .font(.subheadline).bold()
                            .foregroundColor(.primary)
                        Spacer()
                    }
                    .padding(.horizontal)
                })
            Divider()
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(viewModel: CategoriesViewModel(repository: DummyDataRepository()))
    }
}
