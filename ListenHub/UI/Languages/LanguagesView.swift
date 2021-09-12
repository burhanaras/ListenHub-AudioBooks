//
//  LanguagesView.swift
//  ListenHub
//
//  Created by Burhan Aras on 12.09.2021.
//

import SwiftUI

struct LanguagesView: View {
    @ObservedObject var viewModel: LanguagesViewModel
    
    var body: some View {
        NavigationView{
            switch viewModel.data {
            case let .success(languages):
                languagesList(of: languages)
            case let .failure(error):
                ErrorView(error: error)
            case .none:
                LoadingView()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

extension LanguagesView {
    
    func languagesList(of languages: [Language]) -> some View {
        ScrollView {
            VStack{
                Divider()
                LazyVGrid(columns:isIPad ?
                            [GridItem(.flexible(minimum: 0, maximum: .infinity)), GridItem(.flexible(minimum: 0, maximum: .infinity))]
                            :[GridItem(.flexible(minimum: 0, maximum: .infinity))],
                          content: {
                            ForEach(languages) { language in
                                VStack{
                                    NavigationLink(
                                        destination: Text("Language Details"),
                                        label: {
                                            LanguageView(language: language)
                                        })
                                    Divider()
                                }
                            }
                          })
                Spacer()
            }
            .navigationTitle("Languages")
        }
    }
}

struct LanguageView: View {
    let language: Language
    
    var body: some View {
        HStack (alignment: .top, spacing: 12){
            Text(language.emoji).font(.largeTitle)
            VStack (alignment: .leading) {
                Text(language.name)
                    .font(.subheadline).bold()
                    .foregroundColor(.primary)
                
                Text("\(language.originalName)")
                    .font(.subheadline).bold()
                    .foregroundColor(.primary)
                    .opacity(0.6)
            }

            Spacer()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}

struct LanguagesView_Previews: PreviewProvider {
    static var previews: some View {
        LanguagesView(viewModel: LanguagesViewModel())
    }
}
