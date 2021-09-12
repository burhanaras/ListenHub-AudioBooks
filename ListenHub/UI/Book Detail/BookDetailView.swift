//
//  BookDetailView.swift
//  ListenHub
//
//  Created by Burhan Aras on 12.09.2021.
//

import SwiftUI

struct BookDetailView: View {
    @ObservedObject var viewModel: BookDetailViewModel
    private let isIPad: Bool = (UIDevice.current.model == "iPad")
    
    init(viewModel: BookDetailViewModel) {
        _viewModel = .init(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack{
            switch viewModel.book {
            case let .success(book):
                bookDetail(for: book)
            case let .failure(error):
                ErrorView(error: error)
            case .none:
                LoadingView()
            }
        }
    }
}

extension BookDetailView{
    func bookDetail(for book: Book) -> some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                VStack (alignment: .center, spacing: 8) {
                    NetworkImage(imageURL: book.imageURL)
                        .aspectRatio(1, contentMode: .fit)
                        .frame(width: isIPad ? 360 : 240)
                        .cornerRadius(8)
                        .padding(.bottom, 32)
                    Text(book.title)
                        .font(.subheadline).bold()
                        .foregroundColor(.primary)
                        .padding(.bottom, 2)
                    
                    Text(book.author.name)
                        .font(.subheadline).bold()
                        .foregroundColor(.primary)
                        .opacity(0.6)
                    
                    Text("★ ★ ★ ★ ★").foregroundColor(.orange).padding(.bottom)
                    Text("📖 5 Chapters - ⏳ 2 Hours 13 Minutes")
                        .font(.subheadline)
                        .padding(.bottom)
                    
                    playButton.padding(.bottom)
                    
                    Text(book.description).font(.body)
                    
                }
                .padding()
                .padding(.vertical, isIPad ? 32 : 0)
                similarBooks()
                Spacer()
            }
        }
        
    }
    
    func similarBooks() -> some View {
        VStack{
            switch viewModel.similarContent{
            case let .success(similarBooks):
                ShelfView(collection: similarBooks)
            case let .failure(error):
                ErrorView(error: error)
            case .none:
                ProgressView()
            }
        }
    }
    
    var playButton: some View{
        Button(action: {
            
        }, label: {
            VStack{
                if viewModel.isPlaying {
                    Label("LISTENING", systemImage: "airpodspro").font(.subheadline.bold())
                } else {
                    Label("LISTEN NOW", systemImage: "headphones").font(.subheadline.bold())
                }
                
                ColorfulBand()
            }
        })
        .padding(.top)
        .foregroundColor(.white)
        .background(Color("DarkGreen"))
        .cornerRadius(4)
        .shadow(radius: 4)
        .padding()
    }
}

struct ColorfulBand: View {
    var body: some View {
        HStack (spacing: 0){
            Rectangle()
                .foregroundColor(.yellow)
                .frame(maxWidth: .infinity)
            
            Rectangle()
                .foregroundColor(.red)
                .frame(maxWidth: .infinity)
            
            Rectangle()
                .foregroundColor(.green)
                .frame(maxWidth: .infinity)
            
            Rectangle()
                .foregroundColor(.purple)
                .frame(maxWidth: .infinity)
        }
        .frame(height: 6)
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(viewModel: BookDetailViewModel(book: dummyBook))
    }
}
