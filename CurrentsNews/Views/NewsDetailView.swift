//
//  NewsDetailView.swift
//  CurrentsNews
//
//  Created by Вадим Буркин on 24.10.2021.
//

import SwiftUI

struct NewsDetailView: View {
    var article: Article
    var imageURL: URL?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                ImageView(url: imageURL)
                Group {
                    Text(article.title)
                        .font(.headline)
                    Text(article.content)
                    Text("Author: \(article.source.name)")
                        .italic()
                    Text("[Original](article.articleURL)")
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct NewsDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let source = Source(name: "The Verge", url: "https://www.theverge.com")
        let article = Article(
            title: "Samsung announces cloud gaming for Tizen TVs, offers no further details",
            description: "Samsung has announced that it’s working on a cloud-powered game platform for its Tizen smart TVs. The company hasn’t said when it's coming or what games it’ll run, but it’s not the first time it’s worked on this tech.",
            content: "Samsung has announced that it’s jumping into the cloud gaming arena with an offering for its Tizen smart TV platform. The news came during its Samsung Developer Conference keynote, and the company didn’t provide any more details about what games woul... [1726 chars]",
            articleURL: "https://www.football.london/arsenal-fc/news/arsenal-mikel-arteta-leeds-united-21977897",
            imageURL: "https://i2-prod.football.london/incoming/article21978580.ece/ALTERNATES/s1200/0_Martin.jpg",
            source: source)
        let url = imageURL(for: article)
        NewsDetailView(article: article, imageURL: url)
    }
}
