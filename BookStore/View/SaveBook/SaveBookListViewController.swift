//
//  BookListViewController.swift
//  BookStore
//
//  Created by NH on 5/11/25.
//

import UIKit
import SnapKit

class SaveBookListViewController: BaseViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SaveBookCell.self, forCellReuseIdentifier: String(describing: SaveBookCell.self))
        return tableView
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CoreDataManager.shared.fetch()
        tableView.reloadData()
    }
    
    override func setUI() {
        super.setUI()
        
        view.addSubview(tableView)
    }
    
    override func setConstraints() {
        super.setConstraints()
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension SaveBookListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
}

extension SaveBookListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(CoreDataManager.shared.bookEntityData.count)
        return CoreDataManager.shared.bookEntityData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SaveBookCell.self), for: indexPath) as? SaveBookCell else { return UITableViewCell() }
        
        let data = CoreDataManager.shared.bookEntityData[indexPath.row]
        
        cell.configure(data: data)
        
        return cell
    }
    
    
}
