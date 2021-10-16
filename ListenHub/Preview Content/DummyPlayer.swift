//
//  DummyPlayer.swift
//  ListenHub
//
//  Created by Burhan Aras on 16.10.2021.
//

import Foundation
import Combine

class DummyPlayer: Player {
    static let shared = DummyPlayer()
    
    var progressPublisher: AnyPublisher<Int, Never> {
        progress.eraseToAnyPublisher()
    }
    private var progress = CurrentValueSubject<Int, Never> (0)
    
    var playerStatePublisher: AnyPublisher<PlayerState, Never> {
        playerState.eraseToAnyPublisher()
    }
    private var playerState = CurrentValueSubject<PlayerState, Never> (.preparing)
    
    var bookPublisher: AnyPublisher<Book, Never> {
        book.eraseToAnyPublisher()
    }
    private var book = CurrentValueSubject<Book, Never> (dummyBook)
    
    var currentChapterIndexPublisher: AnyPublisher<Int, Never> {
        currentChapterIndex.eraseToAnyPublisher()
    }
    private var currentChapterIndex = CurrentValueSubject<Int, Never> (0)
    
    var currentTimePublisher: AnyPublisher<String, Never> {
        currentTime.eraseToAnyPublisher()
    }
    private var currentTime = CurrentValueSubject<String, Never> ("00:00")
    
    var durationPublisher: AnyPublisher<String, Never> {
        duration.eraseToAnyPublisher()
    }
    private var duration = CurrentValueSubject<String, Never> ("00:00")
    
    func prepare(book: Book, startFrom: Int, playAfterSetup: Bool) {
        guard book.id != self.book.value.id else { return }
        print("Prepare for \(book.title)")
        self.book.send(book)
    }
    
    func togglePlay() {
        if playerState.value == .playing {
            playerState.send(.paused)
        } else {
            playerState.send(.playing)
        }
    }
    
    func skip(to chapterIndex: Int) {
        guard chapterIndex <= book.value.chapters.count else { return }
        currentChapterIndex.send(chapterIndex)
    }
    
    func seek(to percent: Float) {
        let safePercent = max(min(percent, 100), 0)
        progress.send(Int(safePercent))
    }
    
    func skipToNextChapter() {
        guard currentChapterIndex.value + 1 < book.value.chapters.count else { return }
        currentChapterIndex.send(currentChapterIndex.value + 1)
    }
    
    func skipToPreviousChapter() {
        guard currentChapterIndex.value - 1 >= 0 else { return }
        currentChapterIndex.send(currentChapterIndex.value - 1)
    }
    
    func skipForward() {
        let newValue = min(progress.value + 15, 100)
        progress.send(newValue)
    }
    
    func skipBackward() {
        let newValue = max(progress.value - 15, 0)
        progress.send(newValue)
    }
}
