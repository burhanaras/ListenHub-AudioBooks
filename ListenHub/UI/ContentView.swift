//
//  ContentView.swift
//  ListenHub
//
//  Created by Burhan Aras on 11.09.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            HomeView(viewModel: HomeViewModel())
                .tabItem {
                    Image(systemName: "text.book.closed.fill")
                    Text("Home")
                }.tag(0)
            
            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }.tag(1)
            
            Text("Categories")
                .tabItem {
                    Image(systemName: "line.horizontal.3.decrease.circle")
                    Text("Categories")
                }.tag(2)
            
            Text("Languages")
                .tabItem {
                    Image(systemName: "globe")
                    Text("Languages")
                }.tag(3)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
