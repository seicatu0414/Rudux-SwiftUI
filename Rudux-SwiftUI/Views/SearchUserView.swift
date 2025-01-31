//
//  MainListView.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/07.
//

import SwiftUI
import SwiftData
// Presenterを疎結合にするためジェネリクス定義
struct SearchUserView: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var appRouter: AppRouter
    @State private var searchText: String = ""
    @Query private var lookedUsers: [LookedUser]
    var body: some View {
        VStack {
            searchBar
            MiddleListTitleView(title: "過去閲覧したユーザー")
            userList
        }
//        RouterView形式に変えてから無限ループしてしまった
//        .onAppear {
//            store.dispatch(.loadLookedUsers)
//        }
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
        // Stateから呼び出すのをやめ＠Queryで評価。
        // List(store.state.lookedUsers, id: \.id) { user in
        List(lookedUsers, id: \.id) { user in
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
