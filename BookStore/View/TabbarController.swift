//
//  TabbarController.swift
//  BookStore
//
//  Created by NH on 5/11/25.
//

import UIKit

final class TabbarController: BaseTabbarController {
    
    let searchTabVC = SearchTabViewController()
    let bookListVC = BookListViewController()
    
    override func setTabbBar() {
        super.setTabbBar()
        
        searchTabVC.tabBarItem = UITabBarItem(title: "검색 탭", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        bookListVC.tabBarItem = UITabBarItem(title: "담은 책 리스트 탭", image: UIImage(systemName: "book.closed.fill"), tag: 1)
        
        // 뷰컨트롤러를 탭바에 등록
        viewControllers = [
            UINavigationController(rootViewController: searchTabVC),
            UINavigationController(rootViewController: bookListVC)
        ]
    }
}
