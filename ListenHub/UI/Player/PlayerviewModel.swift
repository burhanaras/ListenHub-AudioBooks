//
//  PlayerViewModel.swift
//  ListenHub
//
//  Created by Burhan Aras on 15.09.2021.
//

import Foundation
class PlayerViewModel: ObservableObject {
    public static let shared = PlayerViewModel()
    private var currentlyPlayingBookIdAndChapterId: (String, String) = ("", "")
    
    @Published var book: Book = dummyBook
    @Published var currentChanpterIndex: Int = 0
    @Published var progress: Int = 0
    @Published var isPlaying: Bool = false
    
    func play(book: Book) {
        
    }
    
    func togglePlay() { }
    
    func skip(to chapter: Chapter) {
        
    }
    
    func skipToNextChapter() { }
    
    func skipToPreviousChapter() { }
    
    func seek(to percent: Float) { }
}
