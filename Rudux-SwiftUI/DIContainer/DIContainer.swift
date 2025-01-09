//
//  DIContainer.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/09.
//

class DIContainer {
    let sharedModelContainer: SharedModelContainer
    let searchUserRouter: SearchUserRouter
    let userDetailRouter: UserDetailRouter
    init(
        sharedModelContainer: SharedModelContainer,
        navigationState: NavigationState
    ) {
        self.sharedModelContainer = sharedModelContainer
        self.searchUserRouter = SearchUserRouter(navigationState: navigationState)
        // 新しいルーターはここで追加
        self.userDetailRouter = UserDetailRouter(navigationState: navigationState)
    }
}
