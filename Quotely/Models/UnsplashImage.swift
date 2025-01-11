//
//  UnsplashImage.swift
//  Quotely
//
//  Created by Michael Winkler on 06.01.25.
//

import Foundation

struct UnsplashImage: Identifiable, Decodable {
    let id: String
    let urls: URLS
    let altDescription: String?
    
    struct URLS: Decodable {
        let small: String
        let regular: String
    }
}
