//
//  ImageLoadingView.swift
//  CurrentsNews
//
//  Created by Вадим Буркин on 24.10.2021.
//

import SwiftUI

struct ImageLoadingView: View {
    @StateObject var imageLoader: ImageLoader
    
    init(urlString: String?) {
        self._imageLoader = StateObject(wrappedValue: ImageLoader(from: urlString))
    }
    
    var body: some View {
        Group {
            if let image = imageLoader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipped()
            } else {
                ProgressView()
                    .frame(width: 100, height: 100)
            }
        }
        .task {
            await imageLoader.update()
        }
    }
}

struct ImageLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        let urlString = "https://s.espncdn.com/stitcher/sports/football/nfl/events/401326424.png?templateId=espn.com.share.1"
        ImageLoadingView(urlString: urlString)
    }
}
