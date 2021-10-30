//
//  BookDetailView.swift
//  ListenHub
//
//  Created by Burhan Aras on 12.09.2021.
//

import SwiftUI

struct BookDetailView: View {
    @ObservedObject var viewModel: BookDetailViewModel
    @State var showPlayerSheet: Bool = false
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
                        .shadow(radius: 8)
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
                    Text(book.length)
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
        .sheet(isPresented: $showPlayerSheet, content: {
            Coordinator.shared.playerView()
        })
        
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
            showPlayerSheet.toggle()
            viewModel.play()
        }, label: {
            VStack{
                HStack {
                    if viewModel.showEqualizer {
                        EqualizerView(barCount: 4, color: Color.white, isPlaying: .constant(true)).frame(width: 24, height: 24, alignment: .center)
                    } else {
                        Image(systemName: "airpodspro")
                    }
                    Text(viewModel.playbuttonText).font(.body.bold())
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
                .foregroundColor(Color("Color0"))
                .frame(maxWidth: .infinity)
            
            Rectangle()
                .foregroundColor(Color("Color1"))
                .frame(maxWidth: .infinity)
            
            Rectangle()
                .foregroundColor(Color("Color2"))
                .frame(maxWidth: .infinity)
            
            Rectangle()
                .foregroundColor(Color("Color3"))
                .frame(maxWidth: .infinity)
        }
        .frame(height: 4)
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(viewModel: BookDetailViewModel(repository:DummyDataRepository(), book: dummyBook, player: DummyPlayer.shared))
    }
}
