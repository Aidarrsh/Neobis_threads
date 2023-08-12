//
//  ProfileView.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 12/8/23.
//

import Foundation
import UIKit
import SnapKit

class ProfileView: UIView {
    
    private lazy var professionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfBold(ofSize: 24)
        label.text = "Design Lead"
        
        return label
    }()
    
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfBold(ofSize: 14)
        label.text = "malevicz"
        
        return label
    }()
    
    private lazy var domainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "GreyDomain")
        view.layer.cornerRadius = 13 * UIScreen.main.bounds.height / 852
        
        return view
    }()
    
    private lazy var domainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfRegular(ofSize: 11)
        label.text = "threads.net"
        label.textColor = UIColor(named: "GreyLabel")
        
        return label
    }()
    
    private lazy var profilePicture: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .red
        image.layer.cornerRadius = 35 * UIScreen.main.bounds.height / 852
        
        return image
    }()
    
    private lazy var followersLabel: UIButton = {
        let button = UIButton()
        button.setTitle("18 followers", for: .normal)
        button.titleLabel?.font = UIFont.sfRegular(ofSize: 15)
        button.setTitleColor(UIColor(named: "GreyLabel"), for: .normal)
        
        return button
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
        addSubview(professionLabel)
        addSubview(nicknameLabel)
        addSubview(domainView)
        addSubview(domainLabel)
        addSubview(profilePicture)
        addSubview(followersLabel)
    }
    
    func setupConstraints() {
        professionLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 126))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
//            make.height.equalTo(flexibleHeight(to: 22))
//            make.width.equalTo(flexibleWidth(to: 128))
//            make.trailing.equalToSuperview().inset(flexibleWidth(to: 249))
//            make.bottom.equalToSuperview().inset(flexibleHeight(to: 704))
        }
        
        nicknameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 162))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 320))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 672))
        }
        
        domainView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 158))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 75))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 251))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 668))
        }
        
        domainLabel.snp.makeConstraints{ make in
            make.center.equalTo(domainView)
        }
        
        profilePicture.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 114))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 307))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 668))
        }
        
        followersLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 196))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
//            make.trailing.equalToSuperview().inset(flexibleWidth(to: 305))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 638))
        }
    }
}
