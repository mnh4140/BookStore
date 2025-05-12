//
//  DetailBookViewController.swift
//  BookStore
//
//  Created by NH on 5/12/25.
//

import Foundation
import UIKit
import SnapKit

class DetailBookViewController: BaseViewController {
    let bookTitle = UILabel()
    let authors = UILabel()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    let thumbnail = UIImageView()
    let priceLabel = UILabel()
    let detailLabel = UILabel()

    private let stackView = UIStackView()
    private let cencelButton = UIButton()
    private let saveButton = UIButton()
    
    override func setUI() {
        super.setUI()
        view.backgroundColor = .brown
        
        bookTitle.text = "책 이름"
        bookTitle.textColor = .black
        bookTitle.font = .systemFont(ofSize: 20, weight: .bold)
        bookTitle.textAlignment = .center
        view.addSubview(bookTitle)
        
        authors.text = "저자 이름"
        authors.textColor = .lightGray
        authors.font = .systemFont(ofSize: 14, weight: .regular)
        authors.textAlignment = .center
        view.addSubview(authors)
        
        // 스크롤 영역
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        // 이미지
        thumbnail.contentMode = .scaleAspectFit
        thumbnail.clipsToBounds = true
        thumbnail.image = UIImage(systemName: "book.fill")
        contentView.addSubview(thumbnail)
        
        // 가격
        priceLabel.text = "책 가격 30000원"
        priceLabel.textColor = .black
        priceLabel.font = .systemFont(ofSize: 20, weight: .regular)
        priceLabel.textAlignment = .center
        contentView.addSubview(priceLabel)
        
        // 상세 설명
        detailLabel.text = ""
        detailLabel.font = .systemFont(ofSize: 18, weight: .regular)
        detailLabel.textColor = .black
        detailLabel.numberOfLines = 0
        contentView.addSubview(detailLabel)
        
        // 취소 버튼
        cencelButton.setTitle("X", for: .normal)
        cencelButton.setTitleColor(.white, for: .normal)
        cencelButton.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        cencelButton.layer.cornerRadius = 30
        cencelButton.backgroundColor = .lightGray
        cencelButton.addTarget(self, action: #selector(didTappedCencelButton), for: .touchUpInside)
        
        // 답기 버튼
        saveButton.setTitle("담기", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        saveButton.layer.cornerRadius = 30
        saveButton.backgroundColor = .green
        saveButton.addTarget(self, action: #selector(didTappedSaveButton), for: .touchUpInside)
    
        // 버튼 스택
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 8
        [cencelButton, saveButton].forEach {
            stackView.addArrangedSubview($0)
        }
        view.addSubview(stackView)
        
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        bookTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        authors.snp.makeConstraints { make in
            make.top.equalTo(bookTitle.snp.bottom).offset(8)
            make.height.equalTo(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(authors.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(stackView.snp.top).offset(-12)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        thumbnail.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(400)
            make.width.equalTo(300)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnail.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20) // 중요: contentView의 바닥 고정
        }
        
        stackView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        cencelButton.snp.makeConstraints { make in
            make.width.equalTo(saveButton).multipliedBy(1.0 / 3.0)
        }
    }
    
    @objc
    private func didTappedCencelButton() {
        self.dismissModal()
    }
    
    @objc
    private func didTappedSaveButton() {
        self.dismissModal()
    }
}

    
    }
    
    }
}
