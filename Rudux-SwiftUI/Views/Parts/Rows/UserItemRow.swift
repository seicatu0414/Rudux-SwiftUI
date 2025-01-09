//
//  UserItemRow.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/08.
//

import SwiftUI

struct UserItemsRow: View {
    var title:String
    var updateDay:String
    var tags:[Tag]
    
    init(title: String,
         updateDay: String,
         tags: [Tag]) {
        self.title = title
        self.updateDay = updateDay
        self.tags = tags
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                    Text(" \(tagsText(tags: tags))")
                        .font(.footnote)
                        .foregroundColor(.secondary)
                }
                Spacer()
            }
            .frame(width: geometry.size.width)
            //　無効なフレーム寸法 (負または非有限)らしい
            // ちなみにマイナス値にフレームがなった場合その正の値が返る。
            //.frame(width: .infinity)
        }
        .frame(height: 60)
    }
    
    private func tagsText(tags: [Tag]) -> String {
        return tags.map { $0.name! }.joined(separator: ",")
    }
    
}
