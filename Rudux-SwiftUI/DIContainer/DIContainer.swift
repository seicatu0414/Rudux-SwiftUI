//
//  DIContainer.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/09.
//

class DIContainer {
    let sharedModelContainer: SharedModelContainer
    init(
        sharedModelContainer: SharedModelContainer
    ) {
        self.sharedModelContainer = sharedModelContainer
    }
}
