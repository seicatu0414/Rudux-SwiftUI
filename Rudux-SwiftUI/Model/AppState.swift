//
//  AppState.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/07.
//

struct AppState {
    // SwiftData(使ってない各画面"@Query"で評価)
    //var lookedUsers: [LookedUser] = []
    // API
    var searchUser: [SearchUser] = []
    var items: [SearchUserItem] = []
    var followers: [SearchUserFollower] = []
    var followees: [SearchUserFollowee] = []
    // Other
    var selectedItemUrl: String = ""
}
