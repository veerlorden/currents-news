//
//  Helpers.swift
//  CurrentsNews
//
//  Created by Вадим Буркин on 26.10.2021.
//

import Foundation

func imageURL(for article: Article) -> URL? {
    if let urlString = article.imageURL, let url = URL(string: urlString) {
        return url
    }
    return nil
}

func loadJSON(from filename: String) -> [Article]? {
    let decoder = JSONDecoder()
    guard
        let url = Bundle.main.url(forResource: filename, withExtension: "json"),
        let data = try? Data(contentsOf: url),
        let decodedData = try? decoder.decode(ArticlesWrapper.self, from: data) else {
            return nil
        }
    return decodedData.articles
}
