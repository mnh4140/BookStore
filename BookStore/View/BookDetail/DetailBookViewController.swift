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
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(DetailBookCell.self, forCellWithReuseIdentifier: String(describing: DetailBookCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .cyan
        return collectionView
    }()
    private let bookTitle = UILabel()
    private let authors = UILabel()
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
        
        view.addSubview(collectionView)
        
        cencelButton.setTitle("X", for: .normal)
        cencelButton.setTitleColor(.white, for: .normal)
        cencelButton.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        cencelButton.layer.cornerRadius = 30
        cencelButton.backgroundColor = .lightGray
        cencelButton.addTarget(self, action: #selector(didTappedCencelButton), for: .touchUpInside)
        
        saveButton.setTitle("담기", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.titleLabel?.font = .systemFont(ofSize: 22, weight: .bold)
        saveButton.layer.cornerRadius = 30
        saveButton.backgroundColor = .green
        saveButton.addTarget(self, action: #selector(didTappedSaveButton), for: .touchUpInside)
    
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
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(authors.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(80)
        }
        
        stackView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        cencelButton.snp.makeConstraints { make in
            make.width.equalTo(saveButton).multipliedBy(1.0 / 3.0)
//            make.height.equalTo(50)
//            make.leading.equalToSuperview().offset(20)
//            make.bottom.equalToSuperview().inset(10)
        }
//        saveButton.snp.makeConstraints { make in
//            make.height.equalTo(50)
//            make.leading.equalTo(cencelButton.snp.trailing).offset(8)
//            make.trailing.equalToSuperview().inset(20)
//            make.bottom.equalToSuperview().inset(10)
//        }
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

extension DetailBookViewController: UICollectionViewDelegate {
    
}

extension DetailBookViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailBookCell.self), for: indexPath) as? DetailBookCell else { return UICollectionViewCell() }
        
        return cell
    }
    
    
}
