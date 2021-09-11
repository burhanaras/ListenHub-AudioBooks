//
//  IRepository.swift
//  ListenHub
//
//  Created by Burhan Aras on 11.09.2021.
//

import Foundation

protocol IRepository {
    
}


enum RequestError: Error{
    case badURL
    case sessionExpired
    case noInternet
    case webServiceDown
}
