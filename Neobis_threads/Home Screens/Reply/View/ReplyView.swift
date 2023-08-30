//
//  ReplyView.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 21/8/23.
//

import Foundation
import UIKit
import SnapKit

class ReplyView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Reply"
        label.font = UIFont.sfBold(ofSize: 20)
        
        return label
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "CloseIcon"), for: .normal)
        
        return button
    }()
    
    private lazy var dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(CustomReplyCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        
        return tableView
    }()
    
    lazy var replyTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Anyone can reply"
        textField.font = UIFont.sfRegular(ofSize: 15)
        
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = UIColor(named: "ScreenBackground")
        tableView.dataSource = self
        tableView.delegate = self
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        addSubview(titleLabel)
        addSubview(backButton)
        addSubview(dividerLine)
        addSubview(tableView)
        addSubview(replyTextField)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 72))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 56))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 271))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 756))
        }
        
        backButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 72))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 353))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 756))
        }
        
        dividerLine.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(flexibleHeight(to: 18))
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 737.5))
        }
        
        tableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 148))
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 91))
        }
        
        replyTextField.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 761))
            make.leading.equalToSuperview().inset(flexibleHeight(to: 16))
            make.trailing.equalToSuperview().inset(flexibleHeight(to: 269))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 53))
        }
    }
}

extension ReplyView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomReplyCell

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
