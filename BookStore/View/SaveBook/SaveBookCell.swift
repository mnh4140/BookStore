//
//  SaveBookCell.swift
//  BookStore
//
//  Created by NH on 5/12/25.
//

import UIKit

class SaveBookCell: BaseTableViewCell {
    private let name = UILabel()
    private let author = UILabel()
    private let price = UILabel()
    private let stackView = UIStackView()
    
    override func setUI() {
        super.setUI()
        
        name.text = "책 이름"
        name.textColor = .black
        name.font = .systemFont(ofSize: 18, weight: .medium)
        
        author.text = "저자"
        author.textColor = .lightGray
        author.font = .systemFont(ofSize: 14, weight: .medium)
        
        price.text = "책 가격"
        price.textColor = .black
        price.textAlignment = .right
        price.font = .systemFont(ofSize: 18, weight: .medium)
        
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fill
        [name, author, price].forEach {
            stackView.addArrangedSubview($0)
        }
        contentView.addSubview(stackView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        name.snp.makeConstraints { make in
            make.width.equalTo(stackView).multipliedBy(1.0 / 2.0)
        }
        
        author.snp.makeConstraints { make in
            make.width.equalTo(price).multipliedBy(1.0 / 1.0)
        }
    }
    
    func configure(data: BookEntity) {
        self.name.text = data.title
        self.author.text = data.author
        self.price.text = "\(data.price.formattedWithComma)원"
    }
}
