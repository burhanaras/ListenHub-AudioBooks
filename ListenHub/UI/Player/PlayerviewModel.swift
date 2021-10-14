//
//  PlayerViewModel.swift
//  ListenHub
//
//  Created by Burhan Aras on 15.09.2021.
//

import Foundation
class PlayerViewModel: ObservableObject {
    private var currentlyPlayingBookIdAndChapterId: (String, String) = ("", "")
    
    @Published var name: String = "1"
    @Published var book: Book = dummyBook
    @Published var chapters: [Chapter] = dummyBook.chapters
    
    @Published var currentChanpterIndex: Int = 0
    @Published var progress: Double = 10
    @Published var isPlaying: Bool = false
    

    private var player: Player = DummyPlayer()
    
    init(book: Book) {
        setup(with: book)

    }
    
    func setup(with book: Book) {
        self.book = book
        self.chapters = book.chapters
        var playerItems = [AQPlayerItemInfo]()
        playerItems = book.chapters.map { $0.toAqPlayerItemInfo() }
        AQPlayerManager.shared.setup(with: playerItems, startFrom: 0, playAfterSetup: false)
    }
    
    func play(book: Book) {
        guard book.id != self.book.id else {
            return
        }
        self.book = book
        self.currentChanpterIndex = 0
        
        var playerItems = [AQPlayerItemInfo]()
        playerItems = book.chapters.map { $0.toAqPlayerItemInfo() }
        AQPlayerManager.shared.setup(with: playerItems, startFrom: 0, playAfterSetup: true)
    }
    
    func togglePlay() {
        isPlaying.toggle()
        AQPlayerManager.shared.playOrPause()
    }
    
    func skip(to chapterIndex: Int) {
        guard chapterIndex != currentChanpterIndex else {
            return
        }
        currentChanpterIndex = chapterIndex
        AQPlayerManager.shared.goTo(chapterIndex)
    }
    
    func skipToNextChapter() {
        guard currentChanpterIndex != chapters.count - 1 else {
            return
        }
        currentChanpterIndex += 1
        AQPlayerManager.shared.next()
    }
    
    func skipToPreviousChapter() {
        guard currentChanpterIndex != 0 else {
            return
        }
        currentChanpterIndex -= 1
        AQPlayerManager.shared.previous()
    }
    
    func seek(to percent: Float) {
        AQPlayerManager.shared.seek(toPercent: Double(percent))
    }
    
    func skipForward() {
        AQPlayerManager.shared.skipForward()
    }
    
    func skipBackward() {
        AQPlayerManager.shared.skipBackward()
    }
}
