//
//  NetworkManager.swift
//  BookStore
//
//  Created by NH on 5/11/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager() // 싱글턴 패턴
    
    private init() {}
    
    func fetchData<T: Decodable>(url: URL, completion: @escaping (T?)-> Void) {
        let apiKey = "e51e7ecb085d11c9431dafb9492d337e"
        
        // Request 만들기
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
          "Authorization": "KakaoAK \(apiKey)"
        ]
        
        // URLSession 실행
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // 응답 성공 상태 코드 범위
            let successArrange = (200..<300)
            
            // 에러가 없는지 체크 (조건문 사용)
            guard error == nil else {
                print("에러 발생")
                return
            }
            
            // 데이터가 있는지 체크 (옵셔널 바인딩 사용)
            guard let data = data else {
                print("데이터 불러오기 실패")
                return
            }
            
            // 리스폰스 HTTPURLResponse로 타입캐스팅
            guard let response = response as? HTTPURLResponse else { return }
            
            // 응답에 성공했는지 상태 코드 범위를 통해 확인
            guard successArrange.contains(response.statusCode) else {
                print("통신 오류: \(response.statusCode)")
                return
            }
            
            // data를 decode하는 코드
            guard let responseData = try? JSONDecoder().decode(T.self, from: data)
            else {
                print("디코딩 실패")
                completion(nil)
                return
            }
            completion(responseData)
        }.resume()
    }
}
