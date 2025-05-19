//
//  SaveBookCell.swift
//  BookStore
//
//  Created by NH on 5/12/25.
//

import UIKit

class SaveBookCell: BaseTableViewCell {
    private let name = UILabel() // 책 이름
    private let author = UILabel() // 저자
    private let price = UILabel() // 가격
    private let stackView = UIStackView() // 스택뷰
    
    override func setUI() {
        super.setUI()
        
        // 책 이름
        name.text = "책 이름"
        name.textColor = .black
        name.font = .systemFont(ofSize: 18, weight: .medium)
        
        // 저자
        author.text = "저자"
        author.textColor = .lightGray
        author.font = .systemFont(ofSize: 14, weight: .medium)
        
        // 책 가격
        price.text = "책 가격"
        price.textColor = .black
        price.textAlignment = .right
        price.font = .systemFont(ofSize: 18, weight: .medium)
        
        // 스택뷰
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
    
    // 담은 책 목록 셀 UI 값 설정
    func configure(data: BookEntity) {
        self.name.text = data.title
        self.author.text = data.author
        self.price.text = "\(data.price.formattedWithComma)원"
    }
}
