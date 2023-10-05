//
//  CustomMainCell.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 19/8/23.
//

import Foundation
import UIKit
import SnapKit

class CustomHomeCell: UITableViewCell {
    
    var postImageHeightConstraint: Constraint?
    
    
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
        label.text = "mountain_mama"
        label.font = UIFont.sfBold(ofSize: 14)
        
        return label
    }()
    
    lazy var threadLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfRegular(ofSize: 15)
        label.text = "Innovation sets leaders apart from followers. asdasdasddasfsafasfasfsdafsafdsafsf"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }()

    lazy var postImage: UIImageView = {
        let image = UIImageView()
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
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "3m"
        label.textColor = UIColor(named: "GreyLabel")
        label.font = UIFont.sfRegular(ofSize: 14)
        
        return label
    }()
    
    lazy var likesLabel: UILabel = {
        let label = UILabel()
        label.text = "87 likes"
        label.font = UIFont.sfRegular(ofSize: 14)
        label.textColor = UIColor(named: "GreyLabel")
        
        return label
    }()
    
    static func nib() -> UINib {
        return UINib(nibName: "CustomHomeCell", bundle: nil)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.likeButton.isUserInteractionEnabled = true
        self.repostButton.isUserInteractionEnabled = true
        setupViews()
        setupConstraints()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else { return }
        let touchLocation = touch.location(in: self)
        
        if likeButton.frame.contains(touchLocation) {
            likeButton.becomeFirstResponder()
        }
        
        if repostButton.frame.contains(touchLocation) {
            repostButton.becomeFirstResponder()
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(avatarImage)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(threadLabel)
        contentView.addSubview(postImage)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(repostButton)
        contentView.addSubview(sendButton)
        contentView.addSubview(timeLabel)
        contentView.addSubview(likesLabel)
    }
    
    func setupConstraints() {
        avatarImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 3))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 12))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 345))
            make.height.width.equalTo(flexibleWidth(to: 36))
        }

        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(flexibleWidth(to: 60))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 227))
            make.bottom.equalTo(threadLabel.snp.top).inset(flexibleHeight(to: 3))
        }

        threadLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(21)
            make.leading.equalToSuperview().inset(flexibleWidth(to: 60))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 12))
        }
        
        postImage.snp.makeConstraints{ make in
            make.top.equalTo(threadLabel.snp.bottom).offset(flexibleHeight(to: 10))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 60))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 12))
            make.height.equalTo(0)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(flexibleHeight(to: 15))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 60))
            make.height.equalTo(flexibleHeight(to: 20))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 313))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 30))
        }

        commentButton.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(flexibleHeight(to: 15))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 96))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 277))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 30))
        }

        repostButton.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(flexibleHeight(to: 15))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 132))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 241))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 30))
        }

        sendButton.snp.makeConstraints { make in
            make.top.equalTo(postImage.snp.bottom).offset(flexibleHeight(to: 15))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 168))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 205))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 30))
        }

        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
//            make.leading.equalToSuperview().offset(flexibleWidth(to: 352))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 21))
            make.bottom.equalTo(threadLabel.snp.top).inset(flexibleHeight(to: 3))
        }

        likesLabel.snp.makeConstraints { make in
            make.top.equalTo(likeButton.snp.bottom).offset(flexibleHeight(to: 12))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 60))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 286))
            make.bottom.equalToSuperview()
        }
    }

}
