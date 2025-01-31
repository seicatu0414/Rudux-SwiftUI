//
//  ContentView.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/29.
//
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store:Store
    @EnvironmentObject var appRouter:AppRouter
    @State private var routerView = RouterView { SearchUserView() }
    var body: some View {
            routerView
                .environmentObject(store)
                .environmentObject(appRouter)
    }
}
