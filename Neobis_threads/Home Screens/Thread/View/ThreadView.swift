//
//  ThreadView.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 19/8/23.
//

import Foundation
import UIKit
import SnapKit

class ThreadView: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Thread"
        label.font = UIFont.sfBold(ofSize: 20)
        
        return label
    }()
    
    private lazy var dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        
        return view
    }()
    
    lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "AvatarTwo")
        
        return image
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "iamnalimov"
        label.font = UIFont.sfBold(ofSize: 14)
        
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "1m"
        label.font = UIFont.sfRegular(ofSize: 14)
        label.textColor = UIColor(named: "GreyLabel")
        
        return label
    }()
    
    lazy var threadLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfRegular(ofSize: 15)
        label.text = "Focusing is about saying no. Stay focused on what truly matters."
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var postImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "SteveJobsImage")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var likeIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "LikeIcon")
        
        return image
    }()
    
    lazy var commentIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "CommentIcon")
        
        return image
    }()
    
    lazy var repostIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "RepostBlackIcon")
        
        return image
    }()
    
    lazy var sendIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "SendIcon")
        
        return image
    }()
    
    lazy var replyLabel: UILabel = {
        let label = UILabel()
        label.text = "1 reply"
        label.font = UIFont.sfRegular(ofSize: 15)
        label.textColor = UIColor(named: "GreyLabel")
        
        return label
    }()
    
    lazy var dividerDot: UILabel = {
        let label = UILabel()
        label.text = "•"
        label.textColor = UIColor(named: "GreyLabel")
        
        return label
    }()
    
    lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.text = "941 likes"
        label.font = UIFont.sfRegular(ofSize: 15)
        label.textColor = UIColor(named: "GreyLabel")
        
        return label
    }()
    
    private lazy var postDividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "GreyButtonBorder")
        
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(CustomThreadCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        
        return tableView
    }()
    
    lazy var replyTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor(named: "GreyDomain")
        textField.layer.cornerRadius = 22 * UIScreen.main.bounds.height / 852
        textField.placeholder = "Reply to iamnalimov"
        textField.font = UIFont.sfRegular(ofSize: 14)
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 42, height: textField.frame.height))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        return textField
    }()
    
    lazy var replyAvatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "UserPicture")
        image.contentMode = .scaleAspectFit
        
        return image
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
        addSubview(dividerLine)
        addSubview(avatarImage)
        addSubview(usernameLabel)
        addSubview(timeLabel)
        addSubview(threadLabel)
        addSubview(postImage)
        addSubview(likeIcon)
        addSubview(commentIcon)
        addSubview(repostIcon)
        addSubview(sendIcon)
        addSubview(replyLabel)
        addSubview(dividerDot)
        addSubview(likesLabel)
        addSubview(postDividerLine)
        addSubview(tableView)
        addSubview(replyTextField)
        addSubview(replyAvatarImage)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 72))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 56))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 271))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 756))
        }
        
        dividerLine.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(flexibleHeight(to: 18))
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 737.5))
        }
        
        avatarImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 134))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 13.5))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 343.5))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 682))
        }
        
        usernameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 143))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 59.4))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 260.5))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 691))
        }
        
        timeLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 143))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 353.5))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 21.5))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 691))
        }
        
        threadLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 186))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
        }
        
        postImage.snp.makeConstraints{ make in
            make.top.equalTo(threadLabel.snp.bottom).offset(flexibleHeight(to: 10))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
        }
        
        likeIcon.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(flexibleHeight(to: 15))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 357))
            make.height.equalTo(flexibleHeight(to: 20))
        }

        commentIcon.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(flexibleHeight(to: 15))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 52))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 321))
            make.height.equalTo(flexibleHeight(to: 20))
        }

        repostIcon.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(flexibleHeight(to: 15))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 88))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 285))
            make.height.equalTo(flexibleHeight(to: 20))
        }

        sendIcon.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(flexibleHeight(to: 15))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 124))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 249))
            make.height.equalTo(flexibleHeight(to: 20))
        }
        
        replyLabel.snp.makeConstraints{ make in
            make.top.equalTo(sendIcon.snp.bottom).offset(flexibleHeight(to: 12))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
        }
        
        dividerDot.snp.makeConstraints{ make in
            make.centerY.equalTo(replyLabel.snp.centerY)
            make.leading.equalTo(replyLabel.snp.trailing).offset(flexibleWidth(to: 5))
//            make.trailing.equalTo(likesLabel.snp.leading).inset(flexibleWidth(to: 10))
        }
        
        likesLabel.snp.makeConstraints{ make in
            make.top.equalTo(sendIcon.snp.bottom).offset(flexibleHeight(to: 12))
            make.leading.equalTo(dividerDot.snp.trailing).offset(flexibleWidth(to: 5))
        }
        
        postDividerLine.snp.makeConstraints{ make in
            make.top.equalTo(likesLabel.snp.bottom).offset(flexibleHeight(to: 14))
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(flexibleHeight(to: 0.5))
        }
        
        tableView.snp.makeConstraints{ make in
            make.top.equalTo(postDividerLine.snp.bottom).offset(flexibleHeight(to: 14))
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 98))
        }
        
        replyTextField.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 777))
            make.leading.trailing.equalToSuperview().inset(flexibleHeight(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 31))
        }
        
        replyAvatarImage.snp.makeConstraints{ make in
            make.top.equalTo(replyTextField.snp.top).offset(flexibleHeight(to: 10))
            make.leading.equalTo(replyTextField.snp.leading).offset(flexibleHeight(to: 10))
            make.trailing.equalTo(replyTextField.snp.trailing).inset(flexibleHeight(to: 327))
            make.bottom.equalTo(replyTextField.snp.bottom).inset(flexibleHeight(to: 10))
        }
    }
}
