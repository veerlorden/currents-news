//
//  AsyncImageView.swift
//  CurrentsNews
//
//  Created by Вадим Буркин on 26.10.2021.
//

import SwiftUI

struct ImageView: View {
    var url: URL?
    
    var body: some View {
        if let url = url {
            AsyncImage(url: url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure(_):
                    Color.gray
                @unknown default:
                    Image(systemName: "exclamationmark.icloud")
                        .resizable()
                        .scaledToFit()
                }
            }
            .aspectRatio(contentMode: .fit)
            .clipped()
        } else {
            Color.gray
                .aspectRatio(3/2, contentMode: .fit)
        }
    }
}


struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        let url: URL? = nil
        ImageView(url: url)
    }
}
