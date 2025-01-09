//
//  MainListView.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/07.
//

import SwiftUI
// Presenterを疎結合にするためジェネリクス定義
struct SearchUserView: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var navigationState: NavigationState
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack(path: $navigationState.navigationPath) {
            VStack {
                searchBar
                MiddleListTitleView(title: "過去閲覧したユーザー")
                userList
            }
            .onAppear {
                store.dispatch(.loadLookedUsers)
            }
            .navigationDestination(for: SearchUser.self) { user in
                UserDetailView(userInfo: user)
                    .environmentObject(store)
                    .environmentObject(navigationState)
            }
            .navigationDestination(for:[SearchUserFollower].self) { data in
                FollowerAndFolloweeView(followerAndFollowee: true)
                    .environmentObject(store)
                    .environmentObject(navigationState)
            }
            .navigationDestination(for:[SearchUserFollowee].self) { data in
                FollowerAndFolloweeView(followerAndFollowee: false)
                    .environmentObject(store)
                    .environmentObject(navigationState)
            }
        }
        
    }
    
    private var searchBar: some View {
        HStack {
            TextField("ユーザIDを入力", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal)
                .frame(height: 44)
            
            Button(action: {
                store.dispatch(.searchUser(searchText))
            }) {
                Text("検索")
                    .fontWeight(.bold)
                    .frame(maxHeight: .infinity)
                    .padding(.horizontal, 16)
                    .background(Color.qiitaDarkGreen)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .frame(height: 44)
            .padding(5)
        }
        .padding(.top)
    }
    
    
    private var userList: some View {
        List(store.state.lookedUsers, id: \.id) { user in
            Button(action: {
                store.dispatch(.searchUser(user.id!))
            }) {
                SearchedUserRow(
                    userImageUrl: user.profileImageUrl!,
                    userName: user.name ?? "No Name",
                    userFlowerCnt: "\(user.followersCount ?? 0)",
                    userFloweeCnt: "\(user.followeesCount ?? 0)"
                )
                .frame(maxWidth: .infinity)
            }
            .buttonStyle(.plain)
        }
        .listStyle(PlainListStyle())
    }
}
