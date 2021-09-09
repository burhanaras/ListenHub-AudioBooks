//
//  Category.swift
//  ListenHub
//
//  Created by Burhan Aras on 9.09.2021.
//

import Foundation

struct Category: Identifiable {
    let id: String
    let name: String
    let imageURL: URL
    let books: [Book]
}


struct Language: Identifiable {
    let id: String
    let name: String
    let originalName: String
    let books: [Book]
}
