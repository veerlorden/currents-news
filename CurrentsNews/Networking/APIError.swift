//
//  APIError.swift
//  CurrentsNews
//
//  Created by Вадим Буркин on 24.10.2021.
//

import Foundation

enum FetchNewsError: Error {
    case invalidServerResponse(statusCode: Int)
    case invalidURL
    case unsupportedImageData
    case decodingError
}
