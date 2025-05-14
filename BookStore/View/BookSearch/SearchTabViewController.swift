//
//  SearchTabViewController.swift
//  BookStore
//
//  Created by NH on 5/11/25.
//

import UIKit

/// 검색 화면
final class SearchTabViewController: BaseViewController {
    let searchBar = UISearchBar() // 검색 바
    // 검색 결과 나타내는 컬렉션 뷰
    private lazy var resultCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        //collectionView.backgroundColor = .red
        collectionView.register(RecentBookCell.self, forCellWithReuseIdentifier: String(describing: RecentBookCell.self))
        collectionView.register(ResultCell.self, forCellWithReuseIdentifier: String(describing: ResultCell.self))
        collectionView.register(ResultHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: ResultHeaderCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        //collectionView.isHidden = true
        return collectionView
    }()
    private var data: [BookData.Documents] = [] // 셀 데이터를 넣기 위한 데이터, API 통신해서 받아오는 데이터
    private let bookLiskViewModel = BookListViewModel() // ViewModel, API 통신 클래스
    
    private var recentBookData: [RecentBookEntity] = [] // 최근 책 정보 저장
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 최근 본 책 데이터 불러오기
        CoreDataManager.shared.fetchRecentBooks()
        recentBookData = CoreDataManager.shared.recentBookEntityData
        resultCollectionView.reloadData()
    }
    
    override func setUI() {
        super.setUI()
        
        searchBar.delegate = self // 검색 바 기능 추가를 위해
        searchBar.placeholder = "책 이름을 입력해주세요."
        
        view.addSubview(searchBar)
        view.addSubview(resultCollectionView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        // 검색바
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        // 검색 결과
        resultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.searchBar.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    /// 컴포지셔널 레이아웃 적용 메소드
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            case 0: // 최근 책
                // 분기 처리: 최근 본 책이 없으면 헤더가 없는 레이아웃으로 변경
                if CoreDataManager.shared.recentBookEntityData.count != 0 {
                    return self.createRecentBookListLayout()
                } else {
                    return self.createDefaultLayout()
                }
            case 1: // 검색 결과
                return self.createResultBookListLayout()
            default:
                return self.createDefaultLayout()
            }
        }
        return layout
    }
    
    /// 최근 본 책 레이아웃
    private func createRecentBookListLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.35),
            heightDimension: .absolute(140)
        )
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        //group.contentInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)

        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    /// 컴포지셔널 레이아웃 생성 메소드
    private func createResultBookListLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = .init(top: 20, leading: 8, bottom: 0, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(80)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = .init(top: 4, leading: 0, bottom: 0, trailing: 0)
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)

        section.boundarySupplementaryItems = [header]

        return section
    }
    
    /// 헤더가 없는 레이아웃
    private func createDefaultLayout() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = .init(top: 20, leading: 8, bottom: 0, trailing: 8)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(80)
        )
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.contentInsets = .init(top: 4, leading: 0, bottom: 0, trailing: 0)

        return section
    }
    
    /// 데이터 바인딩 메소드
    private func bind(query: String) {
        // 데이터 바인딩
        // API 통신 후 데이터 가져오기
        // query 값으로 검색 데이터를 가져옴
        bookLiskViewModel.fetchBookList(query: query) { [weak self] result in
            guard let self else { return }
            self.data = result // API 로 가져온 데이터를 data 변수에 저장
            DispatchQueue.main.async {
                self.resultCollectionView.reloadData() // 셀 새로고침
                self.resultCollectionView.isHidden = false // 검색 결과 화면 보이기
            }
        }
    }
}

enum Section: Int, CaseIterable {
    case RecentBook
    case SearchBook
    
    var title: String {
        switch self {
        case .RecentBook: return "최근 본 책"
        case .SearchBook: return "검색 결과"
        }
    }
}

// MARK: -서치 바 델리게이트
extension SearchTabViewController: UISearchBarDelegate {
    /// 검색 버튼 누르면 실행되는 메소드
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        bind(query: text) // 검색어를 가지고 API 통신으로 데이터를 가져옴
    }
}

// MARK: - CollectionView 델리게이트, 데이터 소스
extension SearchTabViewController: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.isEmpty ? 1 : 2 // 검색 하지 않으면 섹션 수 1
    }
}

extension SearchTabViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return CoreDataManager.shared.recentBookEntityData.count
        case 1:
            return data.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch Section(rawValue: indexPath.section) {
        case .RecentBook:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RecentBookCell.self), for: indexPath) as? RecentBookCell else { return .init() }
            let data = CoreDataManager.shared.recentBookEntityData[indexPath.row]
            
            cell.configure(data: data)
            
            return cell
        case .SearchBook:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ResultCell.self), for: indexPath) as? ResultCell else { return .init() }
            
            cell.configure(data: data[indexPath.row])
            
            return cell
        default:
            return .init()
        }
    }
    
    // 헤더 설정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: ResultHeaderCell.self), for: indexPath) as? ResultHeaderCell else {
                return UICollectionReusableView()
            }
            
            let section = Section.allCases[indexPath.section]
            
            header.configure(text: section.title)
            return header
        }
        return UICollectionReusableView()
    }
    
    // 셀 선택 시 실행되는 메소드
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailVC = DetailBookViewController()
        
        switch indexPath.section {
        case 0:
            detailVC.setWhatData = "recentBook"
            detailVC.setRecentBookData(data: recentBookData[indexPath.item])
            self.presentModal(detailVC) // 모달 띄우기
        case 1:
            // 책 상세 보기 화면에 데이터 전달
            detailVC.setWhatData = "resultBook"
            detailVC.setBookData(data: data[indexPath.item])
            // 책 담기 알람을 띄우기 위해 델리게이드 적용
            detailVC.delegate = self
            
            self.presentModal(detailVC) // 모달 띄우기
        default:
            return
        }
    }
}

// 책 담기 알림창을 띄우기 위해 델리게이트 패턴
extension SearchTabViewController: Alertable {
    func makeAlert(bookTitle: String) {
        let alert = UIAlertController(
            title: "책 담기 완료",
            message: "\(bookTitle) 책 담기 완료!",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}
