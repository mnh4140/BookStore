//
//  ExtensionInt.swift
//  BookStore
//
//  Created by NH on 5/12/25.
//

import Foundation

// 가격에 콤마 찍기
extension Int {
    var formattedWithComma: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}

extension Int64 {
    var formattedWithComma: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        return formatter.string(from: NSNumber(value: self)) ?? "\(self)"
    }
}
