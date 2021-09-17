//
//  PlayerView.swift
//  ListenHub
//
//  Created by Burhan Aras on 15.09.2021.
//

import SwiftUI

struct PlayerView: View {
    @ObservedObject var viewModel: PlayerviewModel
    
    init(viewModel: PlayerviewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            player
            playerControls
            chapters
        }
    }
}

extension PlayerView {
    var player: some View {
        VStack (alignment: .center, spacing: 8) {
            NetworkImage(imageURL: viewModel.book.imageURL)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: isIPad ? 360 : 240)
                .cornerRadius(8)
                .shadow(radius: 8)
                .padding(.bottom, 32)
            Text(viewModel.book.title)
                .font(.subheadline).bold()
                .foregroundColor(.primary)
                .padding(.bottom, 2)
            
            Text(viewModel.book.author.name)
                .font(.subheadline).bold()
                .foregroundColor(.primary)
                .opacity(0.6)
            
            Text("★ ★ ★ ★ ★").foregroundColor(.orange).padding(.bottom)
            Text(viewModel.book.length)
                .font(.subheadline)
                .padding(.bottom)
        }
    }
    
    var playerControls: some View {
        Text("Player Controls")
    }
    
    var chapters: some View {
        VStack{
            ForEach (viewModel.book.chapters){ chapter in
                HStack {
                    Text(chapter.title)
                    Spacer()
                    Text(chapter.length)
                }
            }
        }
        .padding()
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(viewModel: PlayerviewModel())
    }
}
