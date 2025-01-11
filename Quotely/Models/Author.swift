//
//  Author.swift
//  Quotely
//
//  Created by Michael Winkler on 10.01.25.
//

import Foundation

struct Author: Codable, Identifiable {
    var id: String
    var name: String
    var slug: String
}
