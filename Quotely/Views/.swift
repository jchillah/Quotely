//
//  TabView.swift
//  Quotely
//
//  Created by Michael Winkler on 06.01.25.
//

import SwiftUI

struct Tab: View {
    var body: some View {
        TabView {
            QuoteView()
                .tabItem {
                    Image(systemName: "quote.bubble.fill")
                    Text("Quotes")
                }
            
            CategoryView()
                .tabItem {
                    Image(systemName: "square.grid.2x2.fill")
                    Text("Categories")
                }
        }
    }
}


#Preview {
    Tab()
}
