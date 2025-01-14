//
//  AppAction.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/07.
//

import SwiftUICore

enum AppAction {
    /// SwiftData
    // 画面からのトリガー
    case loadLookedUsers
    // Stateに保存
    case setLookedUsers([LookedUser])
    case saveLookedUser(SearchUser)
    // APIアクセス
    case searchUser(String)
    case setUser(SearchUser)
    case userItems(String)
    case setUserItems([SearchUserItem])
    case follwers(String,Bool)
    case followees(String,Bool)
    case setFollowers([SearchUserFollower],Bool)
    case setFollowees([SearchUserFollowee],Bool)
    case setWebViewOpen(String)
    case popSearchUser
}
