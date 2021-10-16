//
//  NewPlayerViewModel.swift
//  ListenHub
//
//  Created by Burhan Aras on 5.10.2021.
//

import Foundation
import Combine
import UIKit

class PlayerViewModel: ObservableObject{
    @Published var book: Book = dummyBook
    @Published var chapters: [Chapter] = dummyBook.chapters
    
    @Published var currentChanpterIndex: Int = 0
    @Published var progress: Double = 0
    @Published var currentTime: String = ""
    @Published var duration: String = ""
    @Published var isPlaying: Bool = false
    
    private let player: Player
    private var cancellables: Set<AnyCancellable> = []
    
    
    var isDragging = false
    
    init(player: Player){
        self.player = player
        
        self.player.progressPublisher.sink(receiveValue: { [unowned self] prg in
            guard isDragging == false else { return }
            self.progress = Double(prg)
        })
            .store(in: &cancellables)
        
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
        
        self.player.bookPublisher.sink(receiveValue: { [unowned self] book in
            self.book = book
            self.chapters = book.chapters
        })
            .store(in: &cancellables)
        
        self.player.currentChapterIndexPublisher.sink(receiveValue: { [unowned self] currentChapterIndex in
            self.currentChanpterIndex = currentChapterIndex
        })
            .store(in: &cancellables)
        
        self.player.currentTimePublisher.sink(receiveValue: { [unowned self] currentTime in
            self.currentTime = currentTime
        })
            .store(in: &cancellables)
        
        self.player.durationPublisher.sink(receiveValue: { [unowned self] duration in
            self.duration = duration
        })
            .store(in: &cancellables)
    }
    
    
    func togglePlay() {
        self.player.togglePlay()
    }
    
    func skip(to chapterIndex: Int) {
        self.player.skip(to: chapterIndex)
    }
    
    func skipToNextChapter() {
        self.player.skipToNextChapter()
    }
    
    func skipToPreviousChapter() {
        self.player.skipToPreviousChapter()
    }
    
    func seek(to percent: Float) {
        print("Seek to \(percent)")
        self.player.seek(to: percent)
    }
    
    func skipForward(){
        self.player.skipForward()
    }
    
    func skipBackward() {
        self.player.skipBackward()
    }
    
}
