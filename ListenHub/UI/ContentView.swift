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
    @State var play: Bool = false
    
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
                
                Button(action: {
                    showPlayerSheet = true
                }, label: {
//                    Image(systemName: "airpodspro")
//                        .font(.title)
//                        .foregroundColor(.white)
//                        .padding()
//                        .background(
//                            Circle()
//                                .strokeBorder(Color.white,lineWidth: 2)
//                                .background(Circle().foregroundColor(Color.purple)).shadow(radius: 24))
//                        .padding(4)
                    
                    EqualizerView(barCount: 4, color: Color.white, isPlaying: $play).frame(width: 48, height: 48, alignment: .center)
                        .background(
                            Circle()
                                .strokeBorder(Color.white,lineWidth: 2)
                                .background(Circle().foregroundColor(Color.purple)).shadow(radius: 24))
                        .padding(4)
                    
                })
            }
            
        }
        .sheet(isPresented: $showPlayerSheet, content: {
            Coordinator.shared.playerView()
        })
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        ContentView().colorScheme(.dark)
    }
}
