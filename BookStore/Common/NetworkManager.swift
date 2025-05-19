//
//  NetworkManager.swift
//  BookStore
//
//  Created by NH on 5/11/25.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData<T: Decodable>(url: URL, completion: @escaping (T?)-> Void) {
        let apiKey = "e51e7ecb085d11c9431dafb9492d337e"
        
        // 2. Request 만들기
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
          "Authorization": "KakaoAK \(apiKey)"
        ]
        
        // 3. URLSession 실행
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            // 4. 응답 성공 상태 코드 범위
            let successArrange = (200..<300)
            
            // 5. 에러가 없는지 체크 (조건문 사용)
            guard error == nil else {
                print("에러 발생")
                return
            }
            
            // 6. 데이터가 있는지 체크 (옵셔널 바인딩 사용)
            guard let data = data else {
                print("데이터 불러오기 실패")
                return
            }
            
            // 7. 리스폰스 HTTPURLResponse로 타입캐스팅
            guard let response = response as? HTTPURLResponse else { return }
            
            // 8. 응답에 성공했는지 상태 코드 범위를 통해 확인
            guard successArrange.contains(response.statusCode) else {
                print("통신 오류: \(response.statusCode)")
                return
            }
            
            // 9. data를 decode하는 코드
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
