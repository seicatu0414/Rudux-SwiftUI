//
//  AppMiddleware.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/07.
//

import Foundation

func createAppMiddleware(diContainer: DIContainer) -> (Store, AppAction) -> Void {
    return { store, action in
        switch action {
        // 使ってない。＠Queryに変更
        //（SearchUserViewのonApearだとsaveLookedUser後にSearchUserViewのonApearにあったloadLookedUsers
        //  が走りStateのデータ更新、Stateのデータ変更をSearchUserViewが検知再レンダリング→SearchUserViewのonApearが走りと無限ループ）
        case .loadLookedUsers:
//            Task {
//                await MainActor.run {
//                    let modelContext = diContainer.sharedModelContainer.modelContainer.mainContext
//                    let swiftDataService = SwiftDataService(modelContext: modelContext)
//
//                    do {
//                        let lookedUsers = try swiftDataService.fetchLookedUsers()
//                        store.dispatch(.setLookedUsers(lookedUsers))
//                    } catch {
//                        print("Failed to fetch items: \(error)")
//                    }
//                }
//            }
            break
        case .saveLookedUser(let userInfo):
            Task {
                await MainActor.run {
                    let modelContext = diContainer.sharedModelContainer.modelContainer.mainContext
                    let swiftDataService = SwiftDataService(modelContext: modelContext)

                    do {
                        try swiftDataService.saveUser(id: userInfo.id,
                                                      name: userInfo.name,
                                                      profileImageUrl: userInfo.profileImageURL,
                                                      followeesCount: userInfo.followeesCount,
                                                      followersCount: userInfo.followersCount)
                    } catch {
                        print("Failed to fetch items: \(error)")
                    }
                }
            }
        case .searchUser(let userId):
            Task {
                let searchUserInfo = try await APIService.sendUserApi(userId: userId)
                await MainActor.run {
                    store.dispatch(.setUser(searchUserInfo))
                }
            }
        case .setUser(let userInfo):
            // データが設定されたら遷移を実行
            Task {
                await MainActor.run {
                    AppRouter.shared.navigateTo(.userDetail(userInfo: userInfo))
                }
            }
        case.userItems(let userId):
            Task {
                let userItems = try await APIService.sendUserItemsApi(userId: userId)
                await MainActor.run {
                    store.dispatch(.setUserItems(userItems))
                }
            }
        case .followees(let userId, let isPush):
            Task {
                let followeesInfo = try await APIService.sendFolloweesApi(userId: userId)
                await MainActor.run {
                    print("Before Dispatch")
                    store.dispatch(.setFollowees(followeesInfo, isPush))
                    print("After Dispatch")
                }
            }
        case .setFollowees(_,let isPush):
            if !isPush {
                Task {
                    await MainActor.run {
                        AppRouter.shared.navigateTo(.followerAndFollowee(FollowerOrFollowee: isPush))
                    }
                }
            }
        case .follwers(let userId,let isPush):
            Task {
                let followersInfo = try await APIService.sendFollowersApi(userId: userId)
                await MainActor.run {
                    store.dispatch(.setFollowers(followersInfo,isPush))
                }

            }
        case .setFollowers(_,let isPush):
            if isPush {
                Task {
                    await MainActor.run {
                        AppRouter.shared.navigateTo(.followerAndFollowee(FollowerOrFollowee: isPush))
                    }
                }
            }
        default:
            break
        }
    }
}
