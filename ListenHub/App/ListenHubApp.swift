//
//  ListenHubApp.swift
//  ListenHub
//
//  Created by Burhan Aras on 16.08.2021.
//

import SwiftUI

@main
struct ListenHubApp: App {
    var body: some Scene {
        WindowGroup {
            Coordinator.shared.contentView()
        }
    }
}

var isIPad: Bool {
    return UIDevice.current.model == "iPad"
}
