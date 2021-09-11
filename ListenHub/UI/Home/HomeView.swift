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
        switch viewModel.data {
        case let .success(collections):
            collectionList(collections: collections)
        case let .failure(error):
            Text("Error")
        case .none:
            ProgressView()
        }
    }
}

struct CollectionsView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

extension HomeView {
    func collectionList(collections: [Collection]) -> some View {
        ScrollView(.vertical, showsIndicators: false){
            ForEach(collections){ collection in
                Text("")
            }
        }
    }
    
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel())
    }
}
