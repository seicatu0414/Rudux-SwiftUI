
//
//  Enums.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/08.
//

enum Urls:String {
    case MainUrl = "https://qiita.com/api/v2/users/"
    case Items = "/items"
    case Followees = "/followees"
    case Followers = "/followers"
}

enum Errors: Error {
    case decodingError
    case networkError(Int)
    case invalidURL
    case invalidResponse
    case castError
    case swiftDataReadError
    case swiftDataWriteError
    case swiftDataDeleteError
    case containersError
}

