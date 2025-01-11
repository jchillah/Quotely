//
//  QuoteView.swift
//  Quotely
//
//  Created by Michael Winkler on 06.01.25.
//

import SwiftUI

struct QuoteView: View {
    @State private var quote: Quote?
    @State private var isLoading = true
    @AppStorage("selectedLanguage") private var language: String = "DE"
    
    var body: some View {
        VStack {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.purple.opacity(0.5)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()               
                if isLoading {
                    ProgressView("Loading...")
                        .foregroundColor(.primary)
                        .font(.title2)
                } else if let quote = quote {
                    VStack(spacing: 20) {
                        Image(systemName: "quote.opening")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color.purple.opacity(0.8))
                        
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
                    .padding()
                } else {
                    Text("No quote available.")
                        .foregroundColor(.red)
                }
            }
        }
        .onAppear {
            fetchQuote()
        }
    }
    
    private func fetchQuote() {
        isLoading = true
        QuoteService.fetchQuotes { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let quotes):
                    if let firstQuote = quotes.first {
                        quote = firstQuote
                    } else {
                        print("No quotes found.")
                    }
                case .failure(let error):
                    print("Error fetching quote: \(error.localizedDescription)")
                    self.quote = Quote(text: "some-id", author: "Error fetching quote.", id: "Unknown", category: "General", language: "DE")
                }
            }
        }
    }

}

#Preview {
    QuoteView()
}
