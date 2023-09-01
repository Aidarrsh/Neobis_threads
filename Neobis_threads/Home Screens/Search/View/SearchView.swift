//
//  SearchView.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 27/8/23.
//

import Foundation
import UIKit
import SnapKit

class SearchView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Search"
        label.font = UIFont.sfBold(ofSize: 34)
        
        return label
    }()
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search"
        bar.backgroundImage = UIImage()
        bar.searchTextField.leftView = createEmptyLeftView(size: CGSize(width: 25, height: 25))
        bar.searchTextField.leftViewMode = .always
        bar.searchTextField.clearButtonMode = .always
        
        return bar
    }()
    
    func createEmptyLeftView(size: CGSize) -> UIView {
        let leftView = UIView(frame: CGRect(origin: .zero, size: size))
        leftView.backgroundColor = .clear
        
        return leftView
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(CustomSearchCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = UIColor(named: "ScreenBackground")
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(titleLabel)
        addSubview(searchBar)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 67))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 744))
        }
        
        searchBar.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).inset(flexibleHeight(to: 9))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 4))
            make.trailing.equalToSuperview().inset(flexibleHeight(to: 4))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 699))
        }
        
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(searchBar.snp.bottom).offset(flexibleHeight(to: 6))
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 104))
        }
    }
}
