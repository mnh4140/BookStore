//
//  BookListViewController.swift
//  BookStore
//
//  Created by NH on 5/11/25.
//

import UIKit
import SnapKit

class BookListViewController: BaseViewController {
    private let label = UILabel()
    
    override func setUI() {
        super.setUI()
        
        label.text = "준비중"
        label.textColor = .black
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        
        view.addSubview(label)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
    }
}
