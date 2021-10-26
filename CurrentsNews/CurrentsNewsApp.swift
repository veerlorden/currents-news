//
//  CurrentsNewsApp.swift
//  CurrentsNews
//
//  Created by Вадим Буркин on 22.10.2021.
//

import SwiftUI

@main
struct CurrentsNewsApp: App {
    @StateObject var news = NewsFetcher()
    
    var body: some Scene {
        WindowGroup {
            NewsListView(news: news)
        }
    }
}
