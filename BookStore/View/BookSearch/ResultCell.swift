//
//  resultCell.swift
//  BookStore
//
//  Created by NH on 5/11/25.
//

import UIKit

final class ResultCell: BaseCollectionViewCell {
    private let name = UILabel() // 책 이름
    private let author = UILabel() // 저자
    private let price = UILabel() // 가격
    private let stackView = UIStackView() // 스택뷰
    
    override func setUI() {
        //contentView.backgroundColor = .green
        
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
        
        // 위 컴포넌트를 담는 스택뷰
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.distribution = .fill
        [name, author, price].forEach {
            stackView.addArrangedSubview($0)
        }
        contentView.addSubview(stackView)
        
    }
    
    override func setConstraints() {
        // 스택뷰
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 너비 비율 설정
        name.snp.makeConstraints { make in
            make.width.equalTo(stackView).multipliedBy(1.0 / 2.0)
        }
        
        // 너비 비율 설정
        author.snp.makeConstraints { make in
            make.width.equalTo(price).multipliedBy(1.0 / 1.0)
        }
    }
    
    // 검색 결과 셀 데이터 적용 함수
    func configure(data: BookData.Documents) {
        name.text = data.title
        author.text = data.authors.joined(separator: ",")
        price.text = String(data.price.formattedWithComma) + "원"
    }
}
