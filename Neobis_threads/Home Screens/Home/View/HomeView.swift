//
//  MainPageView.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 15/8/23.
//

import Foundation
import UIKit
import SnapKit

class HomeView: UIView {
    
    private lazy var threadIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ThreadIcon")
        
        return image
    }()
    
    lazy var forYouSection: UIButton = {
        let button = UIButton()
        button.setTitle("For you", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.sfSemiBold(ofSize: 17)
        
        return button
    }()
    
    lazy var leftSectionBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    lazy var followingSection: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.sfSemiBold(ofSize: 17)
        
        return button
    }()
    
    lazy var rightSectionBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(CustomHomeCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        
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
        addSubview(threadIcon)
        addSubview(forYouSection)
        addSubview(leftSectionBottomLine)
        addSubview(followingSection)
        addSubview(rightSectionBottomLine)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        threadIcon.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 62))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 181.37))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 181.52))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 755))
        }
        
        forYouSection.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 105))
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 196))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 699))
        }
        
        leftSectionBottomLine.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 151.5))
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 196))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 699))
        }
        
        followingSection.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 105))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 197))
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 699))
        }
        
        rightSectionBottomLine.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 152))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 197))
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 699))
        }
        
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(leftSectionBottomLine.snp.bottom).offset(flexibleHeight(to: 20))
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 83))
        }
    }
}
