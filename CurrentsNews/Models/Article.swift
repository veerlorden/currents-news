//
//  ModelTypes.swift
//  CurrentsNews
//
//  Created by Вадим Буркин on 22.10.2021.
//

import Foundation

struct Article: Identifiable, Codable {
    let title: String
    let description: String
    let content: String
    let articleURL: String
    let imageURL: String?
    let source: Source
    var id = UUID()
    
    enum CodingKeys: String, CodingKey {
        case title, description, content, source
        case articleURL = "url"
        case imageURL = "image"
    }
}

struct Source: Codable {
    let name: String
    let url: String
}

struct ArticlesWrapper: Codable {
    let totalArticles: Int
    let articles: [Article]
}
