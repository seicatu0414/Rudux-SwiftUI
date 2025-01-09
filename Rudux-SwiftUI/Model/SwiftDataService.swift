//
//  SwiftDataService.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/08.
//

import SwiftData
import Foundation
import SwiftUICore
// SwiftDataはメインスレッドで操作推奨外すとWarning
@MainActor
protocol SwiftDataServiceProtocol {
    func fetchLookedUsers() throws -> [LookedUser]
    func saveUser(id: String?, name: String?, profileImageUrl: String?, followeesCount: Int?, followersCount: Int?)  throws
    func deleteUser(user: LookedUser, completion: @escaping (Result<Void, Error>) -> Void)
}

class SwiftDataService: SwiftDataServiceProtocol {
    private let modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }

    // データを取得
    func fetchLookedUsers() throws ->[LookedUser]  {
        let fetchDescriptor = FetchDescriptor<LookedUser>()
        do {
            let users = try modelContext.fetch(fetchDescriptor)
            return users
        } catch {
            print("Error fetching items: \(error)")
            throw Errors.swiftDataReadError
        }
    }

    // データを保存
    func saveUser(id: String?,
                  name: String?,
                  profileImageUrl: String?,
                  followeesCount: Int?,
                  followersCount: Int?)  throws {
        guard let id = id else {
            print("ID cannot be nil")
            return
        }
        
        do {
            // 既存データを取得または新規作成
            // matchingでアンラップしてはいけない（これ起因でエラーに落ちてた）
            let user = try modelContext.findOrInsert(
                matching: #Predicate<LookedUser> { $0.id == id },
                create: LookedUser(id: id,
                                   name: name,
                                   profileImageUrl: profileImageUrl,
                                   followeesCount: followeesCount,
                                   followersCount: followersCount)
            )
            
            // プロパティの更新
            user.id = id
            user.name = name
            user.profileImageUrl = profileImageUrl
            user.followeesCount = followeesCount
            user.followersCount = followersCount
            
            // 保存処理
            try modelContext.save()
            try SharedModelContainer.shared.saveContext() // 通知をトリガー
        } catch {
            throw Errors.swiftDataWriteError
        }
    }

    // データを削除
    func deleteUser(user: LookedUser, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            modelContext.delete(user)
            try modelContext.save()
            completion(.success(()))
        } catch {
            print("Error deleting item: \(error)")
            completion(.failure(Errors.swiftDataDeleteError))
        }
    }
}

