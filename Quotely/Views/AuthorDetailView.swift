//
//  AuthorDetailView.swift
//  Quotely
//
//  Created by Michael Winkler on 10.01.25.
//

import SwiftUI

struct AuthorDetailView: View {
    let author: Author
    @State private var quotes: [Quote] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    var body: some View {
        VStack(spacing: 20) {
            Text("Author Details")
                .font(.title)
                .fontWeight(.bold)

            HStack {
                Text("ID:")
                    .fontWeight(.semibold)
                Spacer()
                Text(author.id)
            }
            .padding(.horizontal)

            HStack {
                Text("Name:")
                    .fontWeight(.semibold)
                Spacer()
                Text(author.name)
            }
            .padding(.horizontal)

            HStack {
                Text("Slug:")
                    .fontWeight(.semibold)
                Spacer()
                Text(author.slug)
            }
            .padding(.horizontal)

            if isLoading {
                ProgressView("Lade Zitate...")
            } else if let errorMessage = errorMessage {
                Text("Fehler: \(errorMessage)")
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
            } else if quotes.isEmpty {
                Text("Keine Zitate für diesen Autor gefunden.")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            } else {
                List(quotes) { quote in
                    Text(quote.text)
                        .font(.body)
                        .padding()
                }
            }

            Spacer()
        }
        .onAppear {
            fetchQuotes(for: author)
        }
        .navigationTitle(author.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private func fetchQuotes(for author: Author) {
        let quoteService = QuoteService()
        
        quoteService.fetchQuotesByAuthor(authorId: author.id) { result in
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
    AuthorDetailView(author: Author(id: "123", name: "John Doe", slug: "john-doe"))
}
