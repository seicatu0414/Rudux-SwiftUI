//
//  LookedUser.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/08.
//

import Foundation
import SwiftData
import SwiftUICore
// 過去にサーチしたユーザー情報
@Model
class LookedUser:Identifiable {
    var id: String?
    var name: String?
    var profileImageUrl: String?
    var followeesCount: Int?
    var followersCount: Int?
    init(id: String?, name: String?, profileImageUrl: String?, followeesCount: Int?, followersCount: Int?) {
        self.id = id
        self.name = name
        self.profileImageUrl = profileImageUrl
        self.followeesCount = followeesCount
        self.followersCount = followersCount
    }
}
