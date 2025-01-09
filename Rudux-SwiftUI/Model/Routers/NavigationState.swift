//
//  NavigationState.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/09.
//
import SwiftUI

class NavigationState: ObservableObject {
    @Published var navigationPath: NavigationPath = NavigationPath()
}
