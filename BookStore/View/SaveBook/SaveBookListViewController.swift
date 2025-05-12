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
        
        self.navigationController?.isNavigationBarHidden = false
        
        CoreDataManager.shared.fetch()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
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
    
    private func setNavigationBar() {
        let title = self.navigationItem.title
        self.navigationItem.title = "담은책"
        
        let allDeleteButton = UIBarButtonItem(title: "  전체 삭제", style: .plain, target: self, action: #selector(allDeleteButton))
        allDeleteButton.tintColor = UIColor.lightGray
        self.navigationItem.leftBarButtonItem = allDeleteButton
        
        let addButton = UIBarButtonItem(title: "추가  ", style: .done, target: self, action: #selector(addButton))
        addButton.tintColor = UIColor.green
        self.navigationItem.rightBarButtonItem = addButton
    }
    
    @objc
    private func allDeleteButton() {
        
    }
    
    @objc
    private func addButton() {
        
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
