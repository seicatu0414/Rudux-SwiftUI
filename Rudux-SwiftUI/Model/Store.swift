//
//  Store.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/07.
//

import Foundation

final class Store: ObservableObject {
    @Published private(set) var state = AppState()
    private var middleware: ((Store, AppAction) -> Void)?
    
    init(initialState: AppState, middleware: ((Store, AppAction) -> Void)? = nil) {
        self.state = initialState
        self.middleware = middleware
    }
    
    func dispatch(_ action: AppAction) {
        appReducer(state: &state, action: action)
        middleware?(self, action)
    }
}
