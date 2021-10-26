//
//  NewsFetcher.swift
//  CurrentsNews
//
//  Created by Вадим Буркин on 22.10.2021.
//

import Foundation
import UIKit

@MainActor
class NewsFetcher: ObservableObject {
    
    private let token = "a610db3eafd28b7116fa36af910fe7be"
    
    @Published private(set) var articles: [Article] = []
    @Published private(set) var isLoading = false
    
    var imageURLs: [URL] {
        articles.compactMap { $0.imageURL } .map { URL(string: $0)! }
    }
    
    func updateItems() async {
        do {
            let fetched = try await fetchTopHeadlines()
            articles = fetched
        } catch FetchNewsError.invalidURL {
            print("Invalid URL")
        } catch FetchNewsError.invalidServerResponse(let status) {
            print("The data was not fetched. Server response status: \(status)")
        } catch FetchNewsError.decodingError {
            print("The data was not decoded")
        } catch {
            print("Unknown error: \(error)")
        }
    }
    
    func fetchTopHeadlines() async throws -> [Article] {
        guard !isLoading else {
            return []
        }
        guard let url = topHeadlinesURL(with: token) else {
            throw FetchNewsError.invalidURL
        }
        
        isLoading = true
        let (data, response) = try await URLSession.shared.data(from: url)
        isLoading = false
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw FetchNewsError.invalidServerResponse(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }
        
        do {
            let decodedData = try JSONDecoder().decode(ArticlesWrapper.self, from: data)
            return decodedData.articles
        } catch {
            throw FetchNewsError.decodingError
        }
    }
    
    func topHeadlinesURL(with token: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "gnews.io"
        components.path = "/api/v4/top-headlines"
        components.queryItems = [
            URLQueryItem(name: "token", value: token),
            URLQueryItem(name: "lang", value: "en")
        ]
        
        return components.url
    }
}
