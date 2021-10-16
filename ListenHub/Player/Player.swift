//
//  Player.swift
//  ListenHub
//
//  Created by Burhan Aras on 30.09.2021.
//

import Foundation
import Combine
import UIKit

protocol Player {
    var progressPublisher: AnyPublisher <Int, Never> { get }
    var playerStatePublisher: AnyPublisher<PlayerState, Never> { get }
    var bookPublisher: AnyPublisher<Book, Never> { get }
    var currentChapterIndexPublisher: AnyPublisher<Int, Never> { get }
    
    func prepare(book: Book, startFrom: Int, playAfterSetup: Bool)
    func togglePlay()
    func skip(to chapterIndex: Int)
    func seek(to percent: Float)
    func skipToNextChapter()
    func skipToPreviousChapter()
    func skipForward()
    func skipBackward()
}

enum PlayerState {
    case preparing
    case playing
    case paused
}

class ListenHubPlayer: Player, AQPlayerDelegate {
    func aQPlayerManager(_ playerManager: AQPlayerManager, progressDidUpdate percentage: Double) {
        self.progress.send(Int(percentage * 100))
    }
    
    func aQPlayerManager(_ playerManager: AQPlayerManager, itemDidChange itemIndex: Int) {
        print("itemDidChange \(itemIndex)")
        self.currentChapterIndex.send(itemIndex % book.value.chapters.count)
    }
    
    func aQPlayerManager(_ playerManager: AQPlayerManager, statusDidChange status: AQPlayerStatus) {
        switch status {
        case .none:
            self.playerState.send(.paused)
        case .loading:
            self.playerState.send(.preparing)
        case .failed:
            self.playerState.send(.paused)
        case .readyToPlay:
            self.playerState.send(.paused)
        case .playing:
            self.playerState.send(.playing)
        case .paused:
            self.playerState.send(.paused)
        }
    }
    
    func getCoverImage(_ player: AQPlayerManager, _ callBack: @escaping (UIImage?) -> Void) {
        
    }
    

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
    
    init(){
        AQPlayerManager.shared.delegate = self
    }
    
    func prepare(book: Book, startFrom: Int, playAfterSetup: Bool) {
        guard book.id != self.book.value.id else { return }
        let playerItems = book.chapters.map{ $0.toAqPlayerItemInfo()}
        AQPlayerManager.shared.setup(with: playerItems, startFrom: startFrom, playAfterSetup: playAfterSetup)
    }
    
    func togglePlay() {
        let state = AQPlayerManager.shared.playOrPause()
        switch state {
        case .none:
            self.playerState.send(.paused)
        case .loading:
            self.playerState.send(.preparing)
        case .failed:
            self.playerState.send(.paused)
        case .readyToPlay:
            self.playerState.send(.paused)
        case .playing:
            self.playerState.send(.playing)
        case .paused:
            self.playerState.send(.paused)
        }
    }
    
    func skip(to chapterIndex: Int) {
        guard chapterIndex <= book.value.chapters.count else { return }
        AQPlayerManager.shared.goTo(chapterIndex)
    }
    
    func seek(to percent: Float) {
        let safePercent = max(min(percent, 100), 0) / 100
        print("Seek to safePercent \(safePercent)")
        AQPlayerManager.shared.seek(toPercent: Double(safePercent))
    }
    
    func skipToNextChapter() {
        guard currentChapterIndex.value + 1 < book.value.chapters.count else { return }
        AQPlayerManager.shared.next()
    }
    
    func skipToPreviousChapter() {
        guard currentChapterIndex.value - 1 >= 0 else { return }
        AQPlayerManager.shared.previous()
    }
    
    func skipForward() {
        AQPlayerManager.shared.skipForward()
    }
    
    func skipBackward() {
        AQPlayerManager.shared.skipBackward()
    }
    
}
