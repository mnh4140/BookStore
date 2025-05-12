//
//  AlertManager.swift
//  BookStore
//
//  Created by NH on 5/12/25.
//

import UIKit

// 델리게이트 패턴을 위한 프로토콜
protocol Alertable: AnyObject {
    func makeAlert(bookTitle: String)
}
