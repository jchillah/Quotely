//
//  NavigatorView.swift
//  Quotely
//
//  Created by Michael Winkler on 06.01.25.
//

import SwiftUI

struct TabViewContainer: View {
    var body: some View {
        NavigationStack {
            ZStack {
                TabView {
                    QuoteView()
                        .tabItem {
                            Label("Quotes", systemImage: "quote.bubble.fill")
                        }
                        .accessibilityLabel("Quotes")
                    
                    AuthorListView()
                        .tabItem {
                            Label("Authors", systemImage: "person.2")
                        }
                        .accessibilityLabel("Authors")
                    
                    InspirationView()
                        .tabItem {
                            Label("Inspiration", systemImage: "photo.fill")
                        }
                        .accessibilityLabel("Inspiration")
                    
                    CategoryView()
                        .tabItem {
                            Label("Categories", systemImage: "list.bullet")
                        }
                        .accessibilityLabel("Categories")
                }
                .font(.system(size: 14))
            }
        }
    }
}

#Preview {
    TabViewContainer()
}
