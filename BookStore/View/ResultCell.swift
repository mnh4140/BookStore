//
//  resultCell.swift
//  BookStore
//
//  Created by NH on 5/11/25.
//

import UIKit

final class ResultCell: BaseCell {
    private let name: UILabel = {
        let label = UILabel()
        label.text = "책 이름"
        label.textColor = .black
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    private let author = UILabel()
    private let price = UILabel()
    
    override func setUI() {
        //contentView.backgroundColor = .green
        contentView.addSubview(name)
    }
    
    override func setConstraints() {
        name.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(8)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(data: BookData.Documents) {
        name.text = data.title
    }
}
