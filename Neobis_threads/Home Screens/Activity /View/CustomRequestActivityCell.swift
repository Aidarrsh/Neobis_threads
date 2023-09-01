//
//  CustomActivityRequestCell.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 1/9/23.
//

import UIKit
import SnapKit

class CustomRequestsActivityCell: UITableViewCell {
    
    var textOne: Int = 20
    
    lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "AvatarFour")
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var profileBadge: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ProfileBadge")
        
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
        label.font = UIFont.sfRegular(ofSize: 14)
        label.textColor = UIColor(named: "GreyLabel")
        label.text = "12m"
        
        return label
    }()
    
    lazy var isFollowedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfRegular(ofSize: 15)
        label.text = "Followed you"
        label.lineBreakMode = .byTruncatingTail
        label.textColor = UIColor(named: "GreyLabel")
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var followButton: UIButton = {
        let button = UIButton()
        button.setTitle("Following", for: .normal)
        button.setTitleColor(UIColor(named: "GreyLabel"), for: .normal)
        button.titleLabel?.font = UIFont.sfSemiBold(ofSize: 14)
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(named: "GreyButtonBorder")?.cgColor
        
        return button
    }()
    
    
    private lazy var dividerLine: UIView = {
        let view = UIView()
        view.layer.borderWidth = 0.33
        view.layer.borderColor = UIColor(named: "GreyButtonBorder")?.cgColor
        view.backgroundColor = UIColor(named: "GreyButtonBorder")
        
        return view
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
        addSubview(profileBadge)
        addSubview(usernameLabel)
        addSubview(timeLabel)
        addSubview(isFollowedLabel)
        addSubview(followButton)
        addSubview(dividerLine)
    }
    
    func setupConstraints() {
        avatarImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 3))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.width.equalTo(flexibleWidth(to: 36))
        }
        
        profileBadge.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 24))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 39))
            make.height.width.equalTo(flexibleWidth(to: 16))
        }

        usernameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(flexibleHeight(to: 2))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 68))
        }
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(flexibleHeight(to: 2))
            make.leading.equalTo(usernameLabel.snp.trailing).offset(flexibleWidth(to: 4))
        }

        isFollowedLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(21)
            make.leading.equalToSuperview().inset(flexibleWidth(to: 68))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 140))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 21))
        }
        
        followButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(4)
            make.leading.equalToSuperview().inset(flexibleWidth(to: 273))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
        }
        
        dividerLine.snp.makeConstraints { make in
            make.top.equalTo(isFollowedLabel.snp.bottom).offset(11.8)
            make.leading.equalToSuperview().inset(flexibleWidth(to: 64))
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 9))
        }
    }
}
