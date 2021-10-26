//
//  ImageGalleryView.swift
//  CurrentsNews
//
//  Created by Вадим Буркин on 25.10.2021.
//

import SwiftUI

struct ImageGalleryView: View {
    var urls: [URL?]
    
    var body: some View {
        PageView(pages: urls.compactMap { ImageView(url: $0) })
    }
}

struct ImageGalleryView_Previews: PreviewProvider {
    static var previews: some View {
        let urls = [URL(string: "https://s.espncdn.com/stitcher/sports/football/nfl/events/401326424.png?templateId=espn.com.share.1")!]
        ImageGalleryView(urls: urls)
    }
}
