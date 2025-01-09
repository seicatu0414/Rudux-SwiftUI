//
//  AppReducer.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/07.
//

func appReducer(state: inout AppState, action: AppAction) {
    // API通信やSwiftDataとやり取りなど非同期通信が必要な物に関しては
    // midlleware処理なんでbreak
    switch action {
    case .loadLookedUsers:
        break
    case .setLookedUsers(let lookedUsers):
        state.lookedUsers = lookedUsers
    case .saveLookedUser(_):
        break
    case .searchUser(_):
        break
    case .setUser(let userInfo):
        state.searchUser = userInfo
    case .userItems(_):
        break
    case .setUserItems(let items):
        state.items = items
    case .follwers(_,_):
        break
    case .setFollowers(let followers,_):
        state.followers = followers
    case .followees(_,_):
        break
    case .setFollowees(let followees,_):
        state.followees = followees
    case .setWebViewOpen(let itemUrl):
        state.selectedItemUrl = itemUrl
    }
}
