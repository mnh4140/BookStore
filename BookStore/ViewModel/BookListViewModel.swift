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
    func fetchBookList(query: String, page: Int = 1, completion: @escaping ([BookData.Documents], BookData.Meta?) -> Void) {
        var components = URLComponents(string: "https://dapi.kakao.com/v3/search/book")
        components?.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        guard let url = components?.url else { return }
        
        // 디버드
        print("검색 결과 최종 요청 URL: \(url)")
        
        NetworkManager.shared.fetchData(url: url) { (result: BookData?) in
            let books = result?.documents ?? []
            let meta = result?.meta
            completion(books, meta)
        }
    }
}
