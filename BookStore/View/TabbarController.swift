//
//  TabbarController.swift
//  BookStore
//
//  Created by NH on 5/11/25.
//

import UIKit

final class TabbarController: BaseTabbarController {
    
    let searchTabVC = SearchTabViewController() // 검생 화면
    let bookListVC = SaveBookListViewController() // 담은 책 화면
    
    override func setTabbBar() {
        super.setTabbBar()
        
        // 탭 바 구성요소 추가
        searchTabVC.tabBarItem = UITabBarItem(title: "검색 탭", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        bookListVC.tabBarItem = UITabBarItem(title: "담은 책 리스트 탭", image: UIImage(systemName: "book.closed.fill"), tag: 1)
        
        // 뷰컨트롤러를 탭바에 등록
        viewControllers = [
            UINavigationController(rootViewController: searchTabVC),
            UINavigationController(rootViewController: bookListVC)
        ]
    }
}
