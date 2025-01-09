//
//  UserDetailRouter.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/09.
//

import SwiftUI

class UserDetailRouter {
    private let navigationState: NavigationState

    init(navigationState: NavigationState) {
        self.navigationState = navigationState
    }
    func pushToFollowersDetail(user: [SearchUserFollower]) {
        navigationState.navigationPath.append(user)
    }
    func pushToFolloweesDetail(user: [SearchUserFollowee]) {
        navigationState.navigationPath.append(user)
    }
}
