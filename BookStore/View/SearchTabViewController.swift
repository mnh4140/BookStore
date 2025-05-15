//
//  SearchTabViewController.swift
//  BookStore
//
//  Created by NH on 5/11/25.
//

import UIKit

final class SearchTabViewController: BaseViewController {
    private let searchBar = UISearchBar()
    private lazy var resultCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createCompositionalLayout())
        //collectionView.backgroundColor = .red
        collectionView.register(ResultCell.self, forCellWithReuseIdentifier: String(describing: ResultCell.self))
        collectionView.register(ResultHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: ResultHeaderCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isHidden = true
        return collectionView
    }()
    private var data: [BookData.Documents] = []
    private let book = BookListViewModel()
    
    override func setUI() {
        super.setUI()
        
        searchBar.delegate = self
        searchBar.placeholder = "책 이름을 입력해주세요."
        
        view.addSubview(searchBar)
        view.addSubview(resultCollectionView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        
        resultCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.searchBar.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(100)
        }
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            switch sectionIndex {
            case 0: // 최근 책
                return self.createDefaultLayout()
            case 1: // 검색 결과
                return self.createDefaultLayout()
            default:
                return self.createDefaultLayout()
            }
        }
        return layout
    }
    
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
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(50))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize,
                                                                 elementKind: UICollectionView.elementKindSectionHeader,
                                                                 alignment: .top)

        section.boundarySupplementaryItems = [header]

        return section
    }
    
    private func bind(query: String) {
        // 데이터 바인딩
        book.fetchBookList(query: query) { [weak self] result in
            guard let self else { return }
            self.data = result
            DispatchQueue.main.async {
                self.resultCollectionView.reloadData()
                self.resultCollectionView.isHidden = false
            }
        }
    }
}

extension SearchTabViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        bind(query: text)
    }
}

extension SearchTabViewController: UICollectionViewDelegate {
    
}

extension SearchTabViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ResultCell.self), for: indexPath) as? ResultCell else { return .init() }
        
        cell.configure(data: data[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: ResultHeaderCell.self), for: indexPath) as? ResultHeaderCell else {
                return UICollectionReusableView()
            }
            header.configure(text: "검색 결과")
            return header
        }
        return UICollectionReusableView()
    }
}
