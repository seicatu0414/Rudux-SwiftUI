//
//  Rudux_SwiftUIApp.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/07.
//

import SwiftUI
import SwiftData

@main
struct Rudux_SwiftUIApp: App {
    @StateObject private var store: Store
    @StateObject private var sharedModelContainer = SharedModelContainer.shared
    @StateObject private var appRouter = AppRouter.shared
    
    init() {
        // 最初にStateObjectをローカル変数で初期化
        let sharedModelContainer = SharedModelContainer.shared
        
        // 依存関係を解決
        let diContainer = DIContainer(
            sharedModelContainer: sharedModelContainer
        )
        
        // Storeの初期化時にmiddlewareにdiContainerを渡す
        let middleware = createAppMiddleware(diContainer: diContainer)
        let store = Store(initialState: AppState(), middleware: middleware)
        
        // @StateObjectに代入
        _sharedModelContainer = StateObject(wrappedValue: sharedModelContainer)
        _store = StateObject(wrappedValue: store)
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appRouter.path) {
                ContentView()
                    .environmentObject(store)
                    .environmentObject(appRouter)
            }
        }
        .modelContainer(sharedModelContainer.modelContainer)
    }
}
