//
//  CustomCell.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 13/8/23.
//

import UIKit
import SnapKit

class CustomCell: UICollectionViewCell {
    
    lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "AvatarOne")
        image.contentMode = .scaleAspectFit // Ensure that the content of the image view scales properly
        
        return image
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "mountain_mama"
        label.font = UIFont.sfBold(ofSize: 14)
        
        return label
    }()
    
    lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfRegular(ofSize: 15)
        label.text = "Innovation sets leaders apart from followers."
        
        return label
        
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(avatarImage)
        addSubview(usernameLabel)
        addSubview(textLabel)
        addSubview(likeIcon)
        addSubview(commentIcon)
        addSubview(repostIcon)
        addSubview(sendIcon)
        addSubview(timeLabel)
        addSubview(likesLabel)
    }
    
    func setupConstraints() {
        avatarImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 3))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 12))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 345))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 67))
        }
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(flexibleWidth(to: 60))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 227))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 88))
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 21))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 60))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 12))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 65))
        }
        
        likeIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 56))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 60))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 313))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 30))
        }
        
        commentIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 56))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 96))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 277))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 30))
        }
        
        repostIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 56))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 132))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 241))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 30))
        }
        
        sendIcon.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 56))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 168))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 205))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 30))
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(flexibleWidth(to: 352))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 21))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 88))
        }
        
        likesLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 88))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 60))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 286))
            make.bottom.equalToSuperview()
        }
    }
}
