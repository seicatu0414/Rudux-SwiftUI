//
//  SettingsView.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/07.
//
import SwiftUI

struct FollowerAndFolloweeView: View {
    @EnvironmentObject var store: Store
    @State private var isOn: Bool = true // セグメント選択状態
    init(followerOrFollowee:Bool){
        _isOn = State(initialValue: followerOrFollowee)
    }
    
    var body: some View {
        VStack {
            follwerOrFolloweeSegment
            MiddleListTitleView(title: isOn ? "Follower":"Followee")
            if isOn {
                followerListView
            } else {
                followeeListView
            }
        }
        .navigationTitle("Follower & Followee")
        .onChange(of: isOn) {
            fetchUsers()
        }
    }
    
    
    private var follwerOrFolloweeSegment: some View {
        Picker("", selection: $isOn) {
            Text("Follower")
                .tag(true)
            
            Text("Followee")
                .tag(false)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()
    }
    
    private var followerListView: some View {
        List(store.state.followers, id: \.id) { user in
            Button(action: {
                store.dispatch(.searchUser(user.id))
            }) {
                SearchedUserRow(
                    userImageUrl: user.profileImageURL!,
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
    
    private var followeeListView: some View {
        List(store.state.followees, id: \.id) { user in
            Button(action: {
                store.dispatch(.searchUser(user.id))
            }) {
                SearchedUserRow(
                    userImageUrl: user.profileImageURL!,
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
    
    private func fetchUsers() {
        if isOn {
            store.dispatch(.follwers(store.state.searchUser.last!.id,false))
        } else {
            store.dispatch(.followees(store.state.searchUser.last!.id,false))
        }
    }
}
