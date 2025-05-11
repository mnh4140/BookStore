//
//  TabbarController.swift
//  BookStore
//
//  Created by NH on 5/11/25.
//

import UIKit

final class TabbarController: BaseTabbarController {
    
    override func setTabbBar() {
        super.setTabbBar()
        let movieIcon = UIImage(named: "movies")?.withRenderingMode(.alwaysOriginal)
        let favoritesIcon = UIImage(named: "favorites")?.withRenderingMode(.alwaysOriginal)
        
        movieListVC.tabBarItem = UITabBarItem(title: "영화 예매", image: movieIcon, tag: 0)
        favoritesVC.tabBarItem = UITabBarItem(title: "찜 목록", image: favoritesIcon, tag: 1)
        
        // 뷰컨트롤러를 탭바에 등록
        viewControllers = [
            UINavigationController(rootViewController: movieListVC),
            UINavigationController(rootViewController: favoritesVC)
        ]
    }
}
