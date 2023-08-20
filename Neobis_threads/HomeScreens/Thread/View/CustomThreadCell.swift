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
        image.image = UIImage(named: "AvatarThree")
        
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
    }
    
    func setupConstraints() {
        avatarImage.snp.makeConstraints{ make in
            make.top.equalToSuperview()
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
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 10))
        }
    }
}
