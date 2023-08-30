//
//  CustomReplyCel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 27/8/23.
//

import UIKit
import SnapKit

class CustomReplyCell: UITableViewCell {
    
    lazy var avatarImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "AvatarThree")
        
        return image
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "kayou"
        label.font = UIFont.sfBold(ofSize: 14)
        
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "4h"
        label.font = UIFont.sfRegular(ofSize: 14)
        label.textColor = UIColor(named: "GreyLabel")
        
        return label
    }()
    
    lazy var threadLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfRegular(ofSize: 15)
        label.text = "Focusing is something impossible for people with ADHD"
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var connectingLine: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(named: "GreyButtonBorder")?.cgColor
        
        
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
        addSubview(usernameLabel)
        addSubview(timeLabel)
        addSubview(threadLabel)
        addSubview(connectingLine)
    }
    
    func setupConstraints() {
        
        avatarImage.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(flexibleWidth(to: 13.5))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 343.5))
            make.height.width.equalTo(flexibleHeight(to: 36))
        }
        
        usernameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(flexibleWidth(to: 59.5))
            make.height.equalTo(flexibleHeight(to: 20))
        }
        
        timeLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().inset(flexibleWidth(to: 354.5))
            make.height.equalTo(flexibleHeight(to: 20))
        }
        
        threadLabel.snp.makeConstraints{ make in
            make.top.equalTo(timeLabel.snp.bottom).offset(flexibleHeight(to: 4))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 59))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 25))
        }
        
        connectingLine.snp.makeConstraints{ make in
            make.top.equalTo(avatarImage.snp.bottom).offset(flexibleHeight(to: 8))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 32))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 359))
//            make.height.equalTo(flexibleWidth(to: 1))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 8))
        }
    }
}
