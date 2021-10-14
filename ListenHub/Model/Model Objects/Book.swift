//
//  Book.swift
//  ListenHub
//
//  Created by Burhan Aras on 9.09.2021.
//

import Foundation
import UIKit

struct Collection: Identifiable {
    let id: String
    let title: String
    let books: [Book]
}

struct Book: Identifiable {
    let id: String
    let title: String
    let author: Author
    let imageURL: URL
    let description: String
    let length: String
    let chapters: [Chapter]
}

struct Author: Identifiable {
    let id: String
    let name: String
}

struct Chapter: Identifiable {
    let id: String
    let title: String
    let playUrl: String
    let length: String
}



extension Chapter {
    func toAqPlayerItemInfo() -> AQPlayerItemInfo {
        return AQPlayerItemInfo(id: Int(id) ?? 0, url: URL(string: playUrl)!, title: title, albumTitle: title, coverImage: UIImage(named: ""), startAt: 0)
    }
}
