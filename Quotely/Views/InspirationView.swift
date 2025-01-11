//
//  InspirationView.swift
//  Quotely
//
//  Created by Michael Winkler on 08.01.25.
//

import SwiftUI

struct InspirationView: View {
    @State private var images: [UnsplashImage] = []
    @State private var errorMessage: String?

    var body: some View {
        NavigationView {
            ScrollView {
                if images.isEmpty {
                    if let errorMessage = errorMessage {
                        Text("Fehler: \(errorMessage)")
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        ProgressView("Bilder werden geladen...")
                            .padding()
                    }
                } else {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(images) { image in
                            InspirationImageView(image: image)
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Inspiration")
            .onAppear {
                fetchImages()
            }
        }
    }

    private func fetchImages() {
        UnsplashService.shared.fetchImages { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let images):
                    self.images = images
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

#Preview {
    InspirationView()
}
