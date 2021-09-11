//
//  LoadingView.swift
//  ListenHub
//
//  Created by Burhan Aras on 11.09.2021.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack (spacing: 24){
            ProgressView()
            Text("Loading")
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
