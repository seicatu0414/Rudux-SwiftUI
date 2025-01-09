//
//  SharedModelContainer.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/08.
//

import SwiftData
import Foundation

public class SharedModelContainer:ObservableObject {
    //staticは初めてコールされた時にインスタンス化され変数のみメモリに保持される
    static let shared = SharedModelContainer()
    let modelContainer: ModelContainer
    // saveを検知し、Listを再描画するためのフラグ
    @Published var dataChangeCnt: Int = 0
    @MainActor
    var mainContext: ModelContext {
        modelContainer.mainContext
    }

    private init() {
        // 新たな＠Modelエンティティはここに追加
        let schema = Schema([
            LookedUser.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do {
            modelContainer = try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Failed to initialize ModelContainer: \(error)")
        }
    }
    // @pablish変数を変更する時はメインスレッドで行う
    @MainActor
    func saveContext() throws {
        // バージョン番号を更新して変更を通知
        dataChangeCnt += 1
    }
}
