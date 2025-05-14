//
//  BookListViewModel.swift
//  BookStore
//
//  Created by NH on 5/11/25.
//

import Foundation

class BookListViewModel {
 
    init() {}
    
    /// ViewModel 에서 수행해야될 비즈니스 로직
    func fetchBookList(query: String, page: Int = 1, completion: @escaping ([BookData.Documents]) -> Void) {

        var components = URLComponents(string: "https://dapi.kakao.com/v3/search/book")
        
        components?.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "\(page)")
            
        ]
        
        guard let url = components?.url else { return }
        print("검색 결과 최종 요청 URL: \(url)")
        
        NetworkManager.shared.fetchData(url: url) { (result: BookData?) in
            guard let books = result?.documents else { return }
            completion(books)
        }
    }
    
    func fetchMetaData(query: String, page: Int = 1, completion: @escaping (BookData.Meta) -> Void) {
        var components = URLComponents(string: "https://dapi.kakao.com/v3/search/book")
        
        components?.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        guard let url = components?.url else { return }
        print("Meta 최종 요청 URL: \(url)")
        
        NetworkManager.shared.fetchData(url: url) { (result: BookData?) in
            guard let meta = result?.meta else { return }
            completion(meta)
        }
    }
}
