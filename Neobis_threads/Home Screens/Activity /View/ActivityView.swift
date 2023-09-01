//
//  ActivityView.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 1/9/23.
//

import Foundation
import UIKit
import SnapKit

class ActivityView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Activity"
        label.font = UIFont.sfBold(ofSize: 34)
        
        return label
    }()
    
    lazy var commentsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Comments", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.sfBold(ofSize: 15)
        button.backgroundColor = .black
        button.layer.borderWidth = 0
        button.layer.borderColor = UIColor(named: "GreyButtonBorder")?.cgColor
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        
        return button
    }()
    
    lazy var requestsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Requests", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.sfBold(ofSize: 15)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "GreyButtonBorder")?.cgColor
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        
        return button
    }()
    
    lazy var commentsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(CustomCommentsActivityCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        
        return tableView
    }()
    
    lazy var requestsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(CustomRequestsActivityCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        tableView.isHidden = true
        
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
        addSubview(commentsButton)
        addSubview(requestsButton)
        addSubview(commentsTableView)
        addSubview(requestsTableView)
        
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 67))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 744))
        }
        
        commentsButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 117))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 12))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 281))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 699))
        }
        
        requestsButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 117))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 118))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 175))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 699))
        }
        
        commentsTableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 168))
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 104))
        }
        
        requestsTableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 168))
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 104))
        }
    }
}

