//
//  NetworkImage.swift
//  ListenHub
//
//  Created by Burhan Aras on 11.09.2021.
//

import SwiftUI
import Kingfisher
import UIKit

public struct NetworkImage: SwiftUI.View {

  // swiftlint:disable:next redundant_optional_initialization
  @State private var image: UIImage? = nil

  public let imageURL: URL?
  public var placeholderImage: UIImage = UIImage(named: "Placeholder")!
  public let animation: Animation = .easeIn

  public var body: some SwiftUI.View {
    Image(uiImage: image ?? placeholderImage)
      .resizable()
      .onAppear(perform: loadImage)
      .transition(.opacity)
      .id(image ?? placeholderImage)
  }

  private func loadImage() {
    guard let imageURL = imageURL, image == nil else { return }
    KingfisherManager.shared.retrieveImage(with: imageURL) { result in
      switch result {
      case .success(let imageResult):
        withAnimation(self.animation) {
          self.image = imageResult.image
        }
      case .failure:
        break
      }
    }
  }
}

#if DEBUG
// swiftlint:disable:next type_name
struct NetworkImage_Previews: PreviewProvider {
  static var previews: some SwiftUI.View {
    NetworkImage(imageURL: URL(string: "https://www.apple.com/favicon.ico")!,
                 placeholderImage: UIImage(systemName: "xmark")!)
  }
}
#endif
