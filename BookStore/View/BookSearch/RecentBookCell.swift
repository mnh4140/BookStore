//
//  RecentBookCell.swift
//  BookStore
//
//  Created by NH on 5/13/25.
//

import UIKit

final class RecentBookCell: BaseCollectionViewCell {
    private let thumbnail = UIImageView() // 책 썸네일
    private let name = UILabel() // 책 이름
    private let stackView = UIStackView() // 스택뷰
    
    override func setUI() {
        //contentView.backgroundColor = .green
        
        // 썸네일
        thumbnail.image = UIImage(systemName: "book.fill")
        thumbnail.clipsToBounds = true
        thumbnail.layer.cornerRadius = 60
        thumbnail.layer.borderWidth = 3
        thumbnail.layer.borderColor = UIColor.black.cgColor

        contentView.addSubview(thumbnail)
        
        // 책 이름
        name.text = "책 이름"
        name.textColor = .black
        name.font = .systemFont(ofSize: 18, weight: .medium)
        
    }
    
    override func setConstraints() {
        thumbnail.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(120)
            //make.edges.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = nil
    }
    
    // 검색 결과 셀 데이터 적용 함수
    func configure(data: RecentBookEntity) {
        guard let thumbnail = data.thumbnail else { return }
        if let url = URL(string: thumbnail) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: url),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.thumbnail.image = image
                    }
                }
            }
        }
        //name.text = data.title
    }
}
