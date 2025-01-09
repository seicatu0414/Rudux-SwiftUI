//
//  APIService.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/07.
//

import Foundation


struct APIService {
    
    // https://qiita.com/api/v2/users/user_id
    // User情報に紐づくAPIにGetする
    static func sendUserApi(userId: String) async throws -> SearchUser {
        // URL作成
        let url = URL(string: Urls.MainUrl.rawValue + userId)!
        let (data, err) = try await URLSession.shared.data(from: url)
        do {
            return try JSONDecoder().decode(SearchUser.self, from: data)
        } catch {
            let errNum = err.hashValue
            throw Errors.networkError(errNum)
        }
    }
    
    // https://qiita.com/api/v2/users/user_id/items
    // User情報に紐づくItemsAPIにGetする
    static func sendUserItemsApi(userId: String) async throws -> [SearchUserItem] {
        // URL作成
        let url = URL(string: Urls.MainUrl.rawValue + userId + Urls.Items.rawValue)!
        let (data, err) = try await URLSession.shared.data(from: url)
        do {
            return try JSONDecoder().decode([SearchUserItem].self, from: data)
        } catch {
            let errNum = err.hashValue
            throw Errors.networkError(errNum)
        }
    }
    
    // https://qiita.com/api/v2/users/:user_id/followees
    // FolloweeAPIをGetする
    static func sendFolloweesApi(userId: String) async throws -> [SearchUserFollowee] {
        // URL作成
        let url = URL(string: Urls.MainUrl.rawValue + userId + Urls.Followees.rawValue)!
        let (data, err) = try await URLSession.shared.data(from: url)
        do {
            return try JSONDecoder().decode([SearchUserFollowee].self, from: data)
        } catch {
            let errNum = err.hashValue
            throw Errors.networkError(errNum)
        }
    }
    
    // https://qiita.com/api/v2/users/:user_id/followers
    // FollowerAPIをGetする
    static func sendFollowersApi(userId: String) async throws -> [SearchUserFollower] {
        // URL作成
        let url = URL(string: Urls.MainUrl.rawValue + userId + Urls.Followers.rawValue)!
        let (data, err) = try await URLSession.shared.data(from: url)
        do {
            return try JSONDecoder().decode([SearchUserFollower].self, from: data)
        } catch {
            let errNum = err.hashValue
            throw Errors.networkError(errNum)
        }
    }
    // アイコンの取得
    static func sendGetIconData(url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw Errors.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        // URLResponseをHTTPURLResponseにキャストしてステータスコードを取得
        guard let httpResponse = response as? HTTPURLResponse else {
            throw Errors.invalidResponse
        }

        // ステータスコードが200かどうかを確認
        if httpResponse.statusCode == 200 {
            return data
        } else {
            throw Errors.networkError(httpResponse.statusCode)
        }
    }
}
