//
//  FollowersView.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 29/9/23.
//

import Foundation
import UIKit
import SnapKit

class FollowersView: UIView {
    
    lazy var followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.titleLabel?.font = UIFont.sfSemiBold(ofSize: 17)
        button.setTitleColor(.black, for: .normal)
        button.isUserInteractionEnabled = true

        return button
    }()
    
    lazy var followingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.titleLabel?.font = UIFont.sfSemiBold(ofSize: 17)
        button.setTitleColor(.black, for: .normal)
        button.isUserInteractionEnabled = true

        return button
    }()
    
    lazy var pendingButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pending", for: .normal)
        button.titleLabel?.font = UIFont.sfSemiBold(ofSize: 17)
        button.setTitleColor(.black, for: .normal)
        button.isUserInteractionEnabled = true

        return button
    }()
    
    lazy var dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        
        return view
    }()
    
    lazy var underlineOne: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    lazy var underlineTwo: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        
        return view
    }()
    
    lazy var underlineThree: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.isHidden = true
        
        return view
    }()
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar()
        bar.placeholder = "Search"
        bar.backgroundImage = UIImage()
        
        return bar
    }()
    
    lazy var followersTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(CustomFollowersCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        
        return tableView
    }()
    
    lazy var followingTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(CustomFollowingCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        
        return tableView
    }()
    
    lazy var pendingTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(CustomPendingCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        
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
        addSubview(followersButton)
        addSubview(followingButton)
        addSubview(pendingButton)
        addSubview(dividerLine)
        addSubview(underlineOne)
        addSubview(underlineTwo)
        addSubview(underlineThree)
        addSubview(searchBar)
        addSubview(followersTableView)
        addSubview(followingTableView)
        addSubview(pendingTableView)
    }
    
    func setupConstraints() {
        
        followersButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 30))
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 262))
            make.height.equalTo(flexibleHeight(to: 54))
        }
        
        followingButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 30))
            make.leading.equalTo(followersButton.snp.trailing)
            make.width.equalTo(flexibleWidth(to: 131))
            make.height.equalTo(flexibleHeight(to: 54))
        }
        
        pendingButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 30))
            make.leading.equalTo(followingButton.snp.trailing)
            make.trailing.equalToSuperview()
            make.height.equalTo(flexibleHeight(to: 54))
        }
        
        dividerLine.snp.makeConstraints { make in
            make.top.equalTo(followersButton.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(flexibleHeight(to: 1))
        }
        
        underlineOne.snp.makeConstraints { make in
            make.top.equalTo(followersButton.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 262))
            make.height.equalTo(flexibleHeight(to: 1.5))
        }
        
        underlineTwo.snp.makeConstraints { make in
            make.top.equalTo(followersButton.snp.bottom)
            make.leading.equalTo(followersButton.snp.trailing)
            make.width.equalTo(flexibleWidth(to: 131))
            make.height.equalTo(flexibleHeight(to: 1.5))
        }
        
        underlineThree.snp.makeConstraints { make in
            make.top.equalTo(followersButton.snp.bottom)
            make.leading.equalTo(followingButton.snp.trailing)
            make.trailing.equalToSuperview()
            make.height.equalTo(flexibleHeight(to: 1.5))
        }
        
        searchBar.snp.makeConstraints{ make in
            make.top.equalTo(dividerLine.snp.bottom).offset(flexibleHeight(to: 16))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleHeight(to: 16))
            make.height.equalTo(flexibleHeight(to: 36))
        }
        
        followersTableView.snp.makeConstraints{ make in
            make.top.equalTo(searchBar.snp.bottom).offset(flexibleHeight(to: 23))
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        followingTableView.snp.makeConstraints{ make in
            make.top.equalTo(searchBar.snp.bottom).offset(flexibleHeight(to: 23))
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        pendingTableView.snp.makeConstraints{ make in
            make.top.equalTo(searchBar.snp.bottom).offset(flexibleHeight(to: 23))
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}
