//
//  DetailView.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/07.
//
import SwiftUI
import SDWebImageSwiftUI
// Presenterを疎結合にするためジェネリクス定義
struct UserDetailView: View {
    @EnvironmentObject var store: Store
    @EnvironmentObject var navigationState: NavigationState
    @State private var userInfo: SearchUser?
    @State private var isModalPresented = false
    
    init(userInfo: SearchUser) {
        _userInfo = State(initialValue: userInfo)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            userProfile
            MiddleListTitleView(title: "投稿記事一覧")
            itemsList
        }
        .onAppear(){
            self.userInfo = store.state.searchUser
            store.dispatch(.userItems(store.state.searchUser!.id))
            store.dispatch(.saveLookedUser(self.userInfo!))
        }
        .padding()
        .navigationTitle("ユーザ詳細")
        // モーダル遷移の設定
        .sheet(isPresented: $isModalPresented) {
            ItemWebView()
                .environmentObject(store)
        }
    }
    
    private var userProfile: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top, spacing: 4) {
                WebImage(url: URL(string: store.state.searchUser?.profileImageURL ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120, alignment: .center)
                        .clipShape(Circle()) // 丸くする
                        .overlay(
                            Circle().stroke(Color.gray, lineWidth: 2) // 枠線を追加
                        )
                        .shadow(radius: 5) // 影を追加（任意）
                } placeholder: {
                    Rectangle().foregroundColor(.gray)
                }
                .scaledToFit()
                .frame(width: 120, height: 120, alignment: .center)
                VStack(alignment: .leading) {
                    Text(store.state.searchUser?.name ?? "Unknown User")
                        .bold()
                        .font(.title)
                    Text("投稿数: \(store.state.searchUser?.itemsCount ?? 0)")
                    HStack {
                        Button(action: {
                            store.dispatch(.followees(store.state.searchUser!.id, true))
                        }) {
                            Text("following: \(store.state.searchUser?.followeesCount ?? 0)")
                        }
                        .foregroundColor(.stringBlack)
                        
                        Button(action: {
                            store.dispatch(.follwers(store.state.searchUser!.id, true))
                        }) {
                            Text("followers: \(store.state.searchUser?.followersCount ?? 0)")
                        }
                        .foregroundColor(.stringBlack)
                        
                    }
                }
                .padding(20)
            }
        }
    }
    
    private var itemsList: some View {
        List(store.state.items, id: \.id) { item in
            Button(action: {
                if store.state.items.firstIndex(where: { $0.id == item.id }) != nil {
                    store.dispatch(.setWebViewOpen(item.url!))
                    isModalPresented = true
                }
            }) {
                UserItemsRow(title: item.title!, updateDay: item.updatedAt!, tags: item.tags!)
                    .frame(maxWidth: .infinity)
            }
            .buttonStyle(.plain)
        }
        .listStyle(PlainListStyle())
    }
    
    
}
