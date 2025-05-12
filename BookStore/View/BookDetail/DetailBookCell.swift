//
//  DetailBookCell.swift
//  BookStore
//
//  Created by NH on 5/12/25.
//

import UIKit

class DetailBookCell: BaseCell {
    private let thumbnail = UIImageView()
    private let price = UILabel()
    private let detail = UILabel()
    
    override func setUI() {
        super.setUI()

        thumbnail.contentMode = .scaleAspectFit
        thumbnail.clipsToBounds = true
        contentView.addSubview(thumbnail)
        
        price.text = "책 가격"
        price.textColor = .black
        price.font = .systemFont(ofSize: 20, weight: .regular)
        price.textAlignment = .center
        contentView.addSubview(price)
        
        detail.text = "책 가격"
        price.textColor = .black
        price.font = .systemFont(ofSize: 20, weight: .regular)
        price.textAlignment = .center
        contentView.addSubview(price)
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
}
