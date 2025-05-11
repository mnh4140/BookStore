//
//  BookData.swift
//  BookStore
//
//  Created by NH on 5/11/25.
//

import Foundation

struct BookData: Decodable {
    let meta: Meta
    let documents: [Documents]
}

extension BookData {
    struct Meta: Decodable {
        let is_end: Bool
        let pageable_count: Int
        let total_count: Int
    }
}

extension BookData {
    struct Documents: Decodable {
        let authors: [String]
        let contents: String
        let price: Int
        let sale_price: Int
        let title: String
        let thumbnail: String
    }
}
