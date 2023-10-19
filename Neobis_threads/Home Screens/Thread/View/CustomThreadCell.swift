//
//  CustomThreadCell.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 20/8/23.
//

import Foundation
import UIKit
import SnapKit

class CustomThreadCell: UITableViewCell {
    
    lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "UserPicture")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 18 * UIScreen.main.bounds.width / 393
        
        return image
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "kayou"
        label.font = UIFont.sfBold(ofSize: 14)
        
        return label
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.text = "Focusing is something impossible for people with ADHD"
        label.font = UIFont.sfRegular(ofSize: 15)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(avatarImage)
        addSubview(usernameLabel)
        addSubview(commentLabel)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(repostButton)
        addSubview(sendButton)
    }
    
    func setupConstraints() {
        avatarImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 5))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 13.5))
            make.height.width.equalTo(flexibleHeight(to: 35))
        }
        
        usernameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 2))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 59.5))
        }
        
        commentLabel.snp.makeConstraints{ make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(flexibleHeight(to: 4))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 59.5))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(flexibleHeight(to: 17.17))
            make.leading.equalTo(commentLabel.snp.leading)
            make.height.width.equalTo(flexibleHeight(to: 20))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 15))
        }
        
        commentButton.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(flexibleHeight(to: 17.17))
            make.leading.equalTo(likeButton.snp.trailing).offset(flexibleWidth(to: 16))
            make.height.width.equalTo(flexibleHeight(to: 20))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 15))
        }
        
        repostButton.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(flexibleHeight(to: 17.17))
            make.leading.equalTo(commentButton.snp.trailing).offset(flexibleWidth(to: 16))
            make.height.width.equalTo(flexibleHeight(to: 20))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 15))
        }
        
        sendButton.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(flexibleHeight(to: 17.17))
            make.leading.equalTo(repostButton.snp.trailing).offset(flexibleWidth(to: 16))
            make.height.width.equalTo(flexibleHeight(to: 20))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 15))
        }
    }
}
