//
//  CategoryView.swift
//  Quotely
//
//  Created by Michael Winkler on 06.01.25.
//

import SwiftUI

private let categoryService = CategoryService()

struct CategoryView: View {
    @State private var categories: [String] = []
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
                    ProgressView("Lade Kategorien...")
                } else if let errorMessage = errorMessage {
                    ErrorView(errorMessage: errorMessage) {
                        fetchCategories()
                    }
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(categories, id: \.self) { category in
                                NavigationLink(destination: CategoryDetailView(category: category)) {
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(LinearGradient(
                                                gradient: Gradient(colors: [Color.blue.opacity(0.3), Color.purple.opacity(0.3)]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing)
                                            )
                                            .frame(height: 100)

                                        Text(category.capitalized)
                                            .font(.headline)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .onAppear(perform: fetchCategories)
            .navigationTitle("Kategorien")
        }
    }

    private func fetchCategories() {
        categoryService.fetchCategories { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let categories):
                    self.categories = categories
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
    CategoryView()
}
