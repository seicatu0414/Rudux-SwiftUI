//
//  SearchUserRouter.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/09.
//

import SwiftUI

class SearchUserRouter {
    private let navigationState: NavigationState

    init(navigationState: NavigationState) {
        self.navigationState = navigationState
    }
    func pushToUserDetail(user: SearchUser) {
        navigationState.navigationPath.append(user)
    }
}
