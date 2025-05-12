//
//  ResultHeaderCell.swift
//  BookStore
//
//  Created by NH on 5/11/25.
//

import UIKit

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
    
    func configure(text: String) {
        label.text = text
    }
}
