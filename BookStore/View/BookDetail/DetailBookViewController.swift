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
    let bookTitle = UILabel() // 책 이름
    let authors = UILabel() // 저자
    
    private let scrollView = UIScrollView() // 스크롤을 위한 스크롤 뷰
    private let contentView = UIView() // 스크롤 뷰 크기 지정을 위한 뷰
    
    let thumbnail = UIImageView() // 책 썸네일
    let priceLabel = UILabel() // 책 가격
    let detailLabel = UILabel() // 책 소개 글

    private let stackView = UIStackView() // 플로팅 버튼 담는 스택뷰
    private let cencelButton = UIButton() // 취소 버튼
    private let saveButton = UIButton() // 담기 버튼
    
    weak var delegate: Alertable? // 델리게이트 패턴을 위한 변수
    var data: BookData.Documents? //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = data {
            updateUI(data: data) // 검색 화면에서 받아온 데이터로 UI 업데이트
            CoreDataManager.shared.createRecentBooks(data: data) // 최근 본 책 추가
        }
        
        
    }
    
    override func setUI() {
        super.setUI()
        view.backgroundColor = .brown
        
        // 책 이름
        bookTitle.text = "책 이름"
        bookTitle.textColor = .black
        bookTitle.font = .systemFont(ofSize: 20, weight: .bold)
        bookTitle.textAlignment = .center
        view.addSubview(bookTitle)
        
        // 저자
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
        
        // 책 이름
        bookTitle.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        // 저자
        authors.snp.makeConstraints { make in
            make.top.equalTo(bookTitle.snp.bottom).offset(8)
            make.height.equalTo(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
        }
        
        // 스크롤 뷰
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(authors.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(stackView.snp.top).offset(-12)
        }
        
        // 스크롤 뷰 크기 정하는 뷰
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        // 썸네일
        thumbnail.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(400)
            make.width.equalTo(300)
        }
        
        // 가격
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(thumbnail.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
        }
        
        // 책 소개글
        detailLabel.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(20) // 중요: contentView의 바닥 고정
        }
        
        // 버튼 스택뷰
        stackView.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        // 취소 버튼 1:3 비율 너비 설정
        cencelButton.snp.makeConstraints { make in
            make.width.equalTo(saveButton).multipliedBy(1.0 / 3.0)
        }
    }
    
    @objc
    private func didTappedCencelButton() {
        self.dismissModal() // 모달 창 내리기
    }
    
    @objc
    private func didTappedSaveButton() {
        self.dismissModal() // 모달 창 내리기
        
        // 델리게이트, 알림창 띄우기
        if let data = data {
            CoreDataManager.shared.create(data: data) // 코어데이터 저장 데이터 생성
            CoreDataManager.shared.fetch() // 코어데이터 데이터 불러오기
            delegate?.makeAlert(bookTitle: data.title) // 책 담기 완료 알림창 띄우기 (델리게이트 패턴)
        }
    }
    
    // 검색 화면 선택한 셀에서 데이터 받아오기
    // 뷰는 셀처럼 바로 적용이 안됨.
    // 셀처럼 configure 함수로 하면 viewdidload 가 실행되기 전에 되서 적용 안됨
    // 먼저 데이터를 보내서 저장해놓고 viewDidLoad 에서 실행 시켜야됨
    func setBookData(data: BookData.Documents) {
        self.data = data
    }
    
    // 위에서 가져온 선택한 셀 데이터로 UI 값 업데이트
    func updateUI(data: BookData.Documents) {
        self.bookTitle.text = data.title
        self.authors.text = data.authors.joined(separator: ",")
        if let url = URL(string: data.thumbnail) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: url),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.thumbnail.image = image
                    }
                }
            }
        }
        priceLabel.text = "\(data.price.formattedWithComma)원"
        detailLabel.text = data.contents
    }
}
