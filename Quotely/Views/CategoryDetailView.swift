//
//  CategoryDetailView.swift
//  Quotely
//
//  Created by Michael Winkler on 10.01.25.
//

import SwiftUI

struct CategoryDetailView: View {
    let category: String
    @State private var quotes: [Quote] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    private let quoteService = QuoteService()

    var body: some View {
        Group {
            if isLoading {
                ProgressView("Lade Zitate für \(category.capitalized)...")
            } else if let errorMessage = errorMessage {
                Text("Fehler: \(errorMessage)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            } else if quotes.isEmpty {
                Text("Keine Zitate für \(category.capitalized) gefunden.")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            } else {
                List(quotes) { quote in
                    VStack(alignment: .leading, spacing: 8) {
                        Text(quote.text)
                            .font(.title2)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.primary)
                            .padding()
                        
                        Text(quote.author)
                            .font(.footnote)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.purple.opacity(0.1))
                            .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 5)
                    )
                }
            }
        }
        .onAppear {
            fetchQuotes()
        }
        .navigationTitle(category.capitalized)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func fetchQuotes() {
        CategoryService.fetchCategoryQuotes() { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let quotes):
                    self.quotes = quotes
                    self.isLoading = false
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    self.isLoading = false
                }
            }
        }
    }
}

#Preview {
    CategoryDetailView(category: "")
}
