//
//  NewsListView.swift
//  CurrentsNews
//
//  Created by Вадим Буркин on 22.10.2021.
//

import SwiftUI

struct NewsListView: View {
    @ObservedObject var news: NewsFetcher
    
    var body: some View {
        NavigationView {
            List {
                ForEach(news.articles) { article in
                    NavigationLink {
                        NewsDetailView(article: article, imageURL: imageURL(for: article))
                    } label: {
                        NewsRowView(article: article)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        ImageGalleryView(urls: news.imageURLs)
                    } label: {
                        Image(systemName: "photo.on.rectangle.angled")
                    }
                }
            }
            .task {
                await news.updateItems()
            }
            .refreshable {
                await news.updateItems()
            }
            .listStyle(.plain)
            .navigationTitle("Latest News")
        }
        .navigationViewStyle(.stack)
    }
}

struct NewsRowView: View {
    let article: Article
    
    var body: some View {
        HStack {
            ImageView(url: imageURL(for: article))
                .frame(maxWidth: 200)
            Text(article.title)
        }
    }
}

struct NewsListView_Previews: PreviewProvider {
    static var previews: some View {
        let news = NewsFetcher()
        NewsListView(news: news)
    }
}
