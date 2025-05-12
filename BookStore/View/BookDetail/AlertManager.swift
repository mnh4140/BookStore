//
//  AlertManager.swift
//  BookStore
//
//  Created by NH on 5/12/25.
//

import UIKit

protocol Alertable: AnyObject {
    func makeAlert(bookTitle: String)
}
