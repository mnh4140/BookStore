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
        let isEnd: Bool
        let pageableCount: Int
        let totalCount: Int
        
        enum CodingKeys: String, CodingKey {
            case isEnd = "is_end"
            case pageableCount = "pageable_count"
            case totalCount = "total_count"
        }
    }
}

extension BookData {
    struct Documents: Decodable {
        let authors: [String]
        let contents: String
        let price: Int
        let title: String
        let thumbnail: String
    }
}
