//
//  RouterView.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/29.
//

import SwiftUI


struct RouterView<Content: View>: View {
    @EnvironmentObject var router: AppRouter
    @EnvironmentObject var store: Store
    private let content: Content
    
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack(path: $router.path) {
            content
                .navigationDestination(for: AppRouter.Route.self) { route in
                    router.view(for: route)
                        .environmentObject(store)
                        .environmentObject(router)
                }
        }
        .environmentObject(router)
    }
}
