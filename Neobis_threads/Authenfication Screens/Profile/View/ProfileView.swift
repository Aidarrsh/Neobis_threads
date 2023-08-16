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
    
    let profilePicture: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "DefaulProfilePhoto")
        image.layer.cornerRadius = 35 * UIScreen.main.bounds.width / 393
        
        return image
    }()
    
    private lazy var followersLabel: UIButton = {
        let button = UIButton()
        button.setTitle("18 followers", for: .normal)
        button.titleLabel?.font = UIFont.sfRegular(ofSize: 15)
        button.setTitleColor(UIColor(named: "GreyLabel"), for: .normal)
        
        return button
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.sfSemiBold(ofSize: 15)
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        button.layer.borderColor = UIColor(named: "GreyButtonBorder")?.cgColor
        button.layer.borderWidth = 1
        
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share profile", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.sfSemiBold(ofSize: 15)
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        button.layer.borderColor = UIColor(named: "GreyButtonBorder")?.cgColor
        button.layer.borderWidth = 1
        
        return button
    }()
    
    private lazy var threadLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfMedium(ofSize: 15)
        label.text = "Threads"
        
        return label
    }()
    
    private lazy var dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    private lazy var repostImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "RepostIcon")
        
        return image
    }()
    
    private lazy var repostLabel: UILabel = {
        let label = UILabel()
        label.text = "You reposted"
        label.textColor = UIColor(named: "GreyLabel")
        label.font = UIFont.sfRegular(ofSize: 15)
        
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "MyCellReuseIdentifier")
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = UIColor(named: "ScreenBackground")
        collectionView.dataSource = self
        collectionView.delegate = self
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
        addSubview(editButton)
        addSubview(shareButton)
        addSubview(threadLabel)
        addSubview(dividerLine)
        addSubview(repostImage)
        addSubview(repostLabel)
        addSubview(collectionView)
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
            make.width.equalTo(flexibleWidth(to: 70))
            make.height.equalTo(flexibleWidth(to: 70))
        }
        
        followersLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 196))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            //            make.trailing.equalToSuperview().inset(flexibleWidth(to: 305))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 638))
        }
        
        editButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 234))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 205))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 582))
        }
        
        shareButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 234))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 205))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 582))
        }
        
        threadLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 294))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 531))
        }
        
        dividerLine.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 330))
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 521))
        }
        
        repostImage.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 352.5))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 24))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 349))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 479.5))
        }
        
        repostLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 349))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 54))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 256))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 476))
        }
        
        collectionView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 380))
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 83))
        }
    }
}

extension ProfileView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2 // Number of cells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomCell
        
        // Configure the cell
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 393 * UIScreen.main.bounds.width / 393
        let cellHeight = 106 * UIScreen.main.bounds.height / 852
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
