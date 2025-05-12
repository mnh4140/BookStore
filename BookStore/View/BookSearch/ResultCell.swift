//
//  resultCell.swift
//  BookStore
//
//  Created by NH on 5/11/25.
//

import UIKit

final class ResultCell: BaseCollectionViewCell {
    private let name = UILabel()
    private let author = UILabel()
    private let price = UILabel()
    private let stackView = UIStackView()
    
    override func setUI() {
        //contentView.backgroundColor = .green
        
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
        stackView.spacing = 16
        stackView.distribution = .fill
        [name, author, price].forEach {
            stackView.addArrangedSubview($0)
        }
        contentView.addSubview(stackView)
        
    }
    
    override func setConstraints() {
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        name.snp.makeConstraints { make in
            make.width.equalTo(stackView).multipliedBy(1.0 / 2.0)
        }
        
        author.snp.makeConstraints { make in
            make.width.equalTo(price).multipliedBy(1.0 / 2.0)
        }
    }
    
    func configure(data: BookData.Documents) {
        name.text = data.title
        author.text = data.authors.joined(separator: ",")
        price.text = String(data.price.formattedWithComma) + "원"
    }
}
