//
//  Player.swift
//  ListenHub
//
//  Created by Burhan Aras on 30.09.2021.
//

import Foundation
import Combine

protocol Player {
    var progressPublisher: AnyPublisher <Int, Never> { get }
    var playerStatePublisher: AnyPublisher<PlayerState, Never> { get }
    var bookPublisher: AnyPublisher<Book, Never> { get }
    var currentChapterIndexPublisher: AnyPublisher<Int, Never> { get }
    
    func prepare(book: Book)
    func togglePlay()
    func skip(to chapterIndex: Int)
    func seek(to percent: Float)
    func skipToNextChapter()
    func skipToPreviousChapter()
    func skipForward()
    func skipBackward()
}

class DummyPlayer: Player {
    static let shared = DummyPlayer()
    
    var progressPublisher: AnyPublisher<Int, Never> {
        progress.eraseToAnyPublisher()
    }
    var progress = CurrentValueSubject<Int, Never> (0)
    
    var playerStatePublisher: AnyPublisher<PlayerState, Never> { 
        playerState.eraseToAnyPublisher()
    }
    var playerState = CurrentValueSubject<PlayerState, Never> (.preparing)
    
    var bookPublisher: AnyPublisher<Book, Never> {
        book.eraseToAnyPublisher()
    }
    var book = CurrentValueSubject<Book, Never> (dummyBook)
    
    var currentChapterIndexPublisher: AnyPublisher<Int, Never> {
        currentChapterIndex.eraseToAnyPublisher()
    }
    var currentChapterIndex = CurrentValueSubject<Int, Never> (0)
    
    func prepare(book: Book) {
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
        let newValue = max(min(percent, 100), 0)
        progress.send(Int(newValue))
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


enum PlayerState {
    case preparing
    case playing
    case paused
}
