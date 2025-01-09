//
//  MiddleListTitleView.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/08.
//

import SwiftUI
struct MiddleListTitleView: View {
    var title : String = ""
    
    var body: some View {
       GeometryReader { geometry in
           Text(title)
               .fontWeight(.bold)
               .frame(width: geometry.size.width, height: 30, alignment: .leading)
               .padding(.horizontal, 16)
               .background(Color.secondary)
               .foregroundColor(.white)
       }
       .frame(height: 30)
   }
}
