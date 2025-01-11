//
//  AllAuthorsListView.swift
//  Quotely
//
//  Created by Michael Winkler on 09.01.25.
//

import SwiftUI

struct AuthorListView: View {
    @State private var authors: [Author] = []
    @State private var isLoading = true
    @State private var errorMessage: String?

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationStack {
            Group {
                if isLoading {
                    ProgressView("Lade Autoren...")
                } else if let errorMessage = errorMessage {
                    ErrorView(errorMessage: errorMessage) {
                        fetchAuthors()
                    }
                } else {
                    List(authors) { author in
                        NavigationLink(destination: AuthorDetailView(author: author)) {
                            Text(author.name)
                                .font(.headline)
                        }
                    }
                    .padding()
                }
            }
            .onAppear(perform: fetchAuthors)
            .navigationTitle("Autoren")
        }
    }

    private func fetchAuthors() {
        AuthorService.fetchAuthors { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let authors):
                    self.authors = authors
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
    AuthorListView()
}
