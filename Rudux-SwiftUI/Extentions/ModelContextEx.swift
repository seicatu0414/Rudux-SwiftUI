//
//  ModelContextEx.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/08.
//

import SwiftData
import Foundation

extension ModelContext {
    /// 指定された条件でエンティティを検索し、見つからない場合は新規作成するヘルパーメソッド
    /// createには保存したい構造体が入る
    func findOrInsert<T: PersistentModel>(
        matching predicate: Predicate<T>, // 検索条件
        create: @autoclosure () -> T // 新規作成時の生成オブジェクト
    ) throws -> T {
        let fetchDescriptor = FetchDescriptor<T>(predicate: predicate)

        do {
            let results = try self.fetch(fetchDescriptor)
            if let existing = results.first {
                // 一致するオブジェクトがあればそれを返す
                return existing
            } else {
                // 一致するオブジェクトがない場合、新しいオブジェクトを作成して返す
                let newObject = create()
                self.insert(newObject) // データベースに挿入
                return newObject
            }
        } catch {
            print("Fetch failed with error: \(error)")
            throw error
        }
    }
}
