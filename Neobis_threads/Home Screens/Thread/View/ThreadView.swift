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
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.alwaysBounceVertical = true
        scrollView.contentInset.bottom = 1000
        
        return scrollView
    }()
    
    lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "UserPicture")
        image.layer.cornerRadius = 18 * UIScreen.main.bounds.height / 852
        image.clipsToBounds = true
        
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
//        image.image = UIImage(named: "SteveJobsImage")
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.isUserInteractionEnabled = true
        button.setImage(UIImage(named: "LikeIcon"), for: .normal)
        button.backgroundColor = .white
        
        return button
    }()
    
    lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "CommentIcon"), for: .normal)
        
        return button
    }()
    
    lazy var repostButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "RepostBlackIcon"), for: .normal)
        
        return button
    }()
    
    lazy var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "SendIcon"), for: .normal)
        
        return button
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
//        tableView.separatorStyle = .none
        tableView.register(CustomThreadCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        
        return tableView
    }()
    
    lazy var replyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "GreyDomain")
        button.layer.cornerRadius = 22 * UIScreen.main.bounds.height / 852
        button.setTitle("Reply to", for: .normal)
        button.titleLabel?.font = UIFont.sfRegular(ofSize: 14)
        button.setTitleColor(UIColor(named: "GreyLabel"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 42, bottom: 0, right: 0)
        
        return button
    }()
    
    lazy var replyAvatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "UserPicture")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 12 * UIScreen.main.bounds.width / 393
        
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
        addSubview(scrollView)
        scrollView.addSubview(avatarImage)
        scrollView.addSubview(usernameLabel)
        scrollView.addSubview(timeLabel)
        scrollView.addSubview(threadLabel)
        scrollView.addSubview(postImage)
        scrollView.addSubview(likeButton)
        scrollView.addSubview(commentButton)
        scrollView.addSubview(repostButton)
        scrollView.addSubview(sendButton)
        scrollView.addSubview(replyLabel)
        scrollView.addSubview(dividerDot)
        scrollView.addSubview(likesLabel)
        scrollView.addSubview(postDividerLine)
        scrollView.addSubview(tableView)
        addSubview(replyButton)
        addSubview(replyAvatarImage)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 55))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 56))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 756))
        }
        
        dividerLine.snp.makeConstraints{ make in
            make.top.equalTo(titleLabel.snp.bottom).offset(flexibleHeight(to: 18))
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 737.5))
        }
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(dividerLine.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 85))
        }
        
        avatarImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 20))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 13.5))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 343.5))
            make.height.width.equalTo(flexibleWidth(to: 36))
        }
        
        usernameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 29))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 59.4))
        }
        
        timeLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 29))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 353.5))
        }
        
        threadLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 72))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
        }
        
        postImage.snp.makeConstraints{ make in
            make.top.equalTo(threadLabel.snp.bottom).offset(flexibleHeight(to: 10))
            make.leading.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
//            make.height.equalTo(361)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(flexibleHeight(to: 15))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 357))
            make.height.equalTo(flexibleHeight(to: 20))
        }

        commentButton.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(flexibleHeight(to: 15))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 52))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 321))
            make.height.equalTo(flexibleHeight(to: 20))
        }

        repostButton.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(flexibleHeight(to: 15))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 88))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 285))
            make.height.equalTo(flexibleHeight(to: 20))
        }

        sendButton.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(flexibleHeight(to: 15))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 124))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 249))
            make.height.equalTo(flexibleHeight(to: 20))
        }
        
        replyLabel.snp.makeConstraints{ make in
            make.top.equalTo(sendButton.snp.bottom).offset(flexibleHeight(to: 12))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
        }
        
        dividerDot.snp.makeConstraints{ make in
            make.centerY.equalTo(replyLabel.snp.centerY)
            make.leading.equalTo(replyLabel.snp.trailing).offset(flexibleWidth(to: 5))
//            make.trailing.equalTo(likesLabel.snp.leading).inset(flexibleWidth(to: 10))
        }
        
        likesLabel.snp.makeConstraints{ make in
            make.top.equalTo(sendButton.snp.bottom).offset(flexibleHeight(to: 12))
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
            make.bottom.equalTo(self.snp.bottom)
        }
        
        replyButton.snp.makeConstraints{ make in
            make.height.equalTo(flexibleHeight(to: 44))
            make.leading.trailing.equalToSuperview().inset(flexibleHeight(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 31))
        }
        
        replyAvatarImage.snp.makeConstraints{ make in
            make.top.equalTo(replyButton.snp.top).offset(flexibleHeight(to: 10))
            make.leading.equalTo(replyButton.snp.leading).offset(flexibleHeight(to: 10))
            make.trailing.equalTo(replyButton.snp.trailing).inset(flexibleHeight(to: 327))
            make.bottom.equalTo(replyButton.snp.bottom).inset(flexibleHeight(to: 10))
        }
    }
}
