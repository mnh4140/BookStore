//
//  ResultHeaderCell.swift
//  BookStore
//
//  Created by NH on 5/11/25.
//

import UIKit

/// 헤더 설정
final class ResultHeaderCell: BaseCollectionViewCell {
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    override func setUI() {
        super.setUI()
        
        addSubview(label)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // 셀 헤더 설정 함수
    func configure(text: String) {
        label.text = text
    }
}
