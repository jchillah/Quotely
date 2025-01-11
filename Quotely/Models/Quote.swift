//
//  Quote.swift
//  Quotely
//
//  Created by Michael Winkler on 06.01.25.
//

import Foundation

struct Quote: Identifiable, Decodable {
    var text: String
    var author: String
    var id: String
    var category: String
    var language: String
    
    enum CodingKeys: String, CodingKey {
        case text
        case author
        case id
        case category
        case language
    }
}
