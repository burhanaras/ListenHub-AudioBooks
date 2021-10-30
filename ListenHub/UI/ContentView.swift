//
//  ContentView.swift
//  ListenHub
//
//  Created by Burhan Aras on 11.09.2021.
//

import SwiftUI

struct ContentView: View {
    @State var currentTab = 0
    @State var showPlayerSheet: Bool = false
    @State var play: Bool = true
    
    var body: some View {
        
        VStack(spacing: 0){
            
            ZStack(alignment: .bottom) {
                TabView (selection: $currentTab){
                    HomeView(viewModel: HomeViewModel(repository: DummyDataRepository()))
                        .tabItem {
                            Image(systemName: "text.book.closed.fill")
                            Text("Home")
                        }.tag(0)
                    
                    SearchView(viewModel: SearchViewModel(repository: DummyDataRepository()))
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }.tag(1)
                    
                    Text("") // for space
                    
                    CategoriesView(viewModel: CategoriesViewModel(repository: DummyDataRepository()))
                        .tabItem {
                            Image(systemName: "line.horizontal.3.decrease.circle")
                            Text("Categories")
                        }.tag(2)
                    
                    LanguagesView(viewModel: LanguagesViewModel())
                        .tabItem {
                            Image(systemName: "globe")
                            Text("Languages")
                        }.tag(3)
                    
                }
                
                playerButtontton
            }
            
        }
        .sheet(isPresented: $showPlayerSheet, content: {
            Coordinator.shared.playerView()
        })
        
    }
    
    var playerButtontton: some View {
        Button(action: {
            showPlayerSheet = true
        }, label: {
            WavesView(isAnimating: .constant(true))
                .frame(width: 60, height: 60, alignment: .center)
        })
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView().colorScheme(.dark)
    }
}
