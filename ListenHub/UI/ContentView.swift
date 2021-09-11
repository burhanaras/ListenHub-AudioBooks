//
//  ContentView.swift
//  ListenHub
//
//  Created by Burhan Aras on 11.09.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            HomeView(viewModel: HomeViewModel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
