//
//  AppRouter.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/29.
//

import SwiftUI

class AppRouter: ObservableObject {
    static let shared = AppRouter()
    @Published var path: NavigationPath = NavigationPath()

    enum Route: Hashable {
        case userDetail(userInfo: SearchUser)
        case searchUser
        case followerAndFollowee(FollowerOrFollowee:Bool)
    }
    
    @ViewBuilder
    func view(for route: Route) -> some View {
        switch route {
        case .userDetail( let userInfo):
            UserDetailView(userInfo: userInfo)
        case .searchUser:
            SearchUserView()
        case .followerAndFollowee(FollowerOrFollowee: let isFollower):
            FollowerAndFolloweeView(followerOrFollowee: isFollower)
        }
    }
    

    func navigateTo(_ appRoute: Route) {
        DispatchQueue.main.async {
            self.path.append(appRoute)
        }
    }
    

    func navigateBack() {
        path.removeLast()
    }
    

    func popToRoot() {
        path.removeLast(path.count)
    }
}
