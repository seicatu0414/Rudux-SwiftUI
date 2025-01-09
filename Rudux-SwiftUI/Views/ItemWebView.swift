//
//  ItemWebView.swift
//  Rudux-SwiftUI
//
//  Created by yamaguchi kohei on 2025/01/08.
//

import WebKit
import SwiftUI

struct ItemWebView: View {
    @EnvironmentObject var store: Store
    var body: some View {
        VStack {
            WebView(url: URL(string: store.state.selectedItemUrl)!)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
