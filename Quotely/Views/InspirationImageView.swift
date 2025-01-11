//
//  InspirationImageView.swift
//  Quotely
//
//  Created by Michael Winkler on 08.01.25.
//

import SwiftUI

struct InspirationImageView: View {
    let image: UnsplashImage

    var body: some View {
        ZStack(alignment: .bottom) {
            AsyncImage(url: URL(string: image.urls.regular)) { phase in
                switch phase {
                case .empty:
                    ProgressView("Lädt Bild...")
                        .progressViewStyle(CircularProgressViewStyle())
                case .success(let loadedImage):
                    loadedImage
                        .resizable()
                        .scaledToFill()
                        .frame(height: 200)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(height: 200)

            if let description = image.altDescription {
                Text(description)
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(8)
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(8)
                    .padding([.bottom, .leading, .trailing], 8)
            }
        }
        .background(Color(UIColor.secondarySystemBackground))
        .cornerRadius(12)
    }
}

#Preview {
    InspirationImageView(
        image: UnsplashImage(
            id: UUID().uuidString,
            urls: UnsplashImage.URLS(small: "https://via.placeholder.com/50", regular: "https://via.placeholder.com/150"), altDescription: "Ein inspirierendes Bild"
            
        )
    )
}

