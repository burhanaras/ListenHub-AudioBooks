//
//  ErrorView.swift
//  ListenHub
//
//  Created by Burhan Aras on 11.09.2021.
//

import SwiftUI

struct ErrorView: View {
    let error: Error
    var body: some View {
        VStack (spacing: 16){
            switch error {
            case RequestError.badURL:
                Image(systemName: "xmark.circle")
                Text("Bad URL")
            case RequestError.noInternet:
                Image(systemName: "wifi.exclamationmark")
                Text("Check your internet connection.")
            case RequestError.sessionExpired:
                Image(systemName: "xmark.circle")
                Text("Your session expired. Re-login please.")
            case RequestError.webServiceDown:
                Image(systemName: "leaf.arrow.triangle.circlepath")
                Text("ListenHub server is down. Please try again later.")
            default:
                Label("Unknown error occured.", systemImage: "xmark.circle")
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ErrorView(error: RequestError.noInternet)
            ErrorView(error: RequestError.badURL)
            ErrorView(error: RequestError.sessionExpired)
            ErrorView(error: RequestError.webServiceDown)
        }
    }
}
