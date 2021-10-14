//
//  PlayerView.swift
//  ListenHub
//
//  Created by Burhan Aras on 15.09.2021.
//

import SwiftUI

struct PlayerView: View {
    @ObservedObject var viewModel: NewPlayerViewModel
    
    init(viewModel: NewPlayerViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                player
                playerControls
                chapters
            }
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
        .padding(.top)
    }

    var playerControls: some View {
        VStack {
            Slider(value: $viewModel.progress, in: 0...100)
                .padding()
            
            HStack{
                Button(action: {
                    viewModel.skipToPreviousChapter()
                }){
                    Image(systemName: "backward.end")
                        .font(Font.body.weight(.medium))
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                
                Button(action: {
                    viewModel.skipBackward()
                }){
                    Text("-15s")
                        .font(Font.body.weight(.medium))
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                
                Button(action: {
                    viewModel.togglePlay()
                }){
                    ZStack{
                        Circle()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.green)
                        Image(systemName: viewModel.isPlaying ? "pause" : "play.fill")
                            .foregroundColor(.white)
                            .font(Font.largeTitle.weight(.bold))
                            .frame(width: 80, height: 80)
                    }
                }
                
                Button(action: {
                    viewModel.skipForward()
                }){
                    Text("+15s")
                        .font(Font.body.weight(.medium))
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                
                Button(action: {
                    viewModel.skipToNextChapter()
                }){
                    Image(systemName: "forward.end")
                        .font(Font.body.weight(.medium))
                        .frame(minWidth: 0, maxWidth: .infinity)
                }
                
            }
            .padding(.top, 24)
            .padding(.bottom, 24)
        }
    }
    
    var chapters: some View {
        VStack{
            ForEach (viewModel.chapters.indices, id:\.self){ index in
                HStack {
                    if index == viewModel.currentChanpterIndex {
                        Image(systemName: "waveform.circle").frame(width: 24, height: 24)
                    } else {
                        Image(systemName: "waveform.circle").frame(width: 24, height: 24).hidden()
                    }
                    Text(viewModel.chapters[index].title)
                    Spacer()
                    Text(viewModel.chapters[index].length)
                }
                .onTapGesture {
                    viewModel.skip(to: index)
                }
                Divider()
            }
        }
        .padding()
    }
}

struct PlayerView_Previews: PreviewProvider {
    static let player = DummyPlayer()
    static var previews: some View {
        PlayerView(viewModel: NewPlayerViewModel(player: player))
    }
}
