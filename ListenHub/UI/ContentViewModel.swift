//
//  ContentViewModel.swift
//  ListenHub
//
//  Created by Burhan Aras on 30.10.2021.
//

import Foundation
import Combine

class ContentviewModel: ObservableObject {
    @Published var isPlaying: Bool = false
    
    private let player: Player
    private var cancellables: Set<AnyCancellable> = []
    
    
    init(player: Player) {
        self.player = player
        
        self.player.playerStatePublisher.sink(receiveValue: { [unowned self] state in
            switch state {
            case .playing:
                self.isPlaying = true
            case .preparing:
                self.isPlaying = false
            case .paused:
                self.isPlaying = false
            }
        })
            .store(in: &cancellables)
    }
}
