//
//  ImageLoader.swift
//  CurrentsNews
//
//  Created by Вадим Буркин on 24.10.2021.
//

import Foundation
import UIKit

@MainActor
class ImageLoader: ObservableObject {
    
    let urlString: String?
    
    @Published private(set) var image: UIImage? = nil
    @Published private(set) var isLoading = false
    
    init(from urlString: String?) {
        self.urlString = urlString
    }
    
    func update() async {
        do {
            let fetched = try await fetchImage()
            image = fetched
        } catch FetchNewsError.invalidURL {
            print("Invalid URL")
        } catch FetchNewsError.invalidServerResponse(let status) {
            print("The data was not fetched. Server response status: \(status)")
        } catch FetchNewsError.unsupportedImageData {
            print("Unsupported image data. The image was not created")
        } catch {
            print("Unknown error: \(error)")
        }
    }
    
    func fetchImage() async throws -> UIImage? {
        guard !isLoading else {
            return nil
        }

        guard verifyURL(urlString: urlString), let url = URL(string: urlString!) else {
            throw FetchNewsError.invalidURL
        }

        isLoading = true
        let (data, response) = try await URLSession.shared.data(from: url)
        isLoading = false
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw FetchNewsError.invalidServerResponse(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }
        guard let uiImage = UIImage(data: data) else {
            throw FetchNewsError.unsupportedImageData
        }
        
        return uiImage
    }
    
    func verifyURL (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
}
