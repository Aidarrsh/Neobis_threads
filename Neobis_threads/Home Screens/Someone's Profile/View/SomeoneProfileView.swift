//
//  SomeoneProfileView.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 1/9/23.
//

import Foundation
import UIKit
import SnapKit

class SomeoneProfileView: UIView {
    
    lazy var professionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfBold(ofSize: 24)
        label.text = "AlexElle"
        
        return label
    }()
    
    lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfBold(ofSize: 14)
        label.text = "alex_elle"
        
        return label
    }()
    
    lazy var domainView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: "GreyDomain")
        view.layer.cornerRadius = 13 * UIScreen.main.bounds.height / 852
        
        return view
    }()
    
    lazy var domainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfRegular(ofSize: 11)
        label.text = "threads.net"
        label.textColor = UIColor(named: "GreyLabel")
        
        return label
    }()
    
    let profilePicture: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "UserPicture")
        image.layer.cornerRadius = 35 * UIScreen.main.bounds.width / 393
        image.clipsToBounds = true
        
        return image
    }()
    
    lazy var followersLabel: UIButton = {
        let button = UIButton()
        button.setTitle("153k followers", for: .normal)
        button.titleLabel?.font = UIFont.sfRegular(ofSize: 15)
        button.setTitleColor(UIColor(named: "GreyLabel"), for: .normal)
        
        return button
    }()
    
    lazy var followButton: UIButton = {
        let button = UIButton()
        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.sfSemiBold(ofSize: 15)
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        button.backgroundColor = .black
        
        return button
    }()
    
    lazy var threadLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.sfMedium(ofSize: 15)
        label.text = "Threads"
        
        return label
    }()
    
    lazy var dividerLine: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        
        return view
    }()
    
    lazy var repostImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "RepostIcon")
        
        return image
    }()
    
    lazy var repostLabel: UILabel = {
        let label = UILabel()
        label.text = "You reposted"
        label.textColor = UIColor(named: "GreyLabel")
        label.font = UIFont.sfRegular(ofSize: 15)
        
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(CustomSomeoneProfileCell.self, forCellReuseIdentifier: "MyCellReuseIdentifier")
        
        return tableView
    }()
    
    lazy var bottomSheet: CustomBottomShareSheet = {
        let view = CustomBottomShareSheet()
        
        return view
    }()
    
    lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isHidden = true
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = UIColor(named: "ScreenBackground")
        tableView.dataSource = self
        tableView.delegate = self
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
        addSubview(followButton)
        addSubview(threadLabel)
        addSubview(dividerLine)
        addSubview(repostImage)
        addSubview(repostLabel)
        addSubview(tableView)
        addSubview(overlayView)
        addSubview(bottomSheet)
    }
    
    func setupConstraints() {
        
        professionLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 126))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
        }
        
        nicknameLabel.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 162))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 672))
        }
        
        domainView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 158))
            make.leading.equalTo(nicknameLabel.snp.trailing).offset(flexibleWidth(to: 4))
            make.width.equalTo(flexibleWidth(to: 67))
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
        
        followButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 234))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
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
        
        tableView.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 380))
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 83))
        }
        
        bottomSheet.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(flexibleHeight(to: 209))
            make.top.equalToSuperview().offset(UIScreen.main.bounds.height)
        }
        
        overlayView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func presentBottomSheet() {
        
        layoutIfNeeded()
        
        overlayView.isHidden = false
        
        UIView.animate(withDuration: 0.3) {
            self.bottomSheet.frame.origin.y -= self.bottomSheet.frame.height
        }
    }
    
    func dismissBottomSheet() {
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomSheet.frame.origin.y += self.bottomSheet.frame.height
        }) { _ in
            self.bottomSheet.removeFromSuperview()
        }
        
        overlayView.isHidden = true
    }
    
    let model = ["Innovation sets leaders apart from followers.", "When I look at you, I see someone who’s working hard"]
}

extension SomeoneProfileView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellReuseIdentifier", for: indexPath) as! CustomSomeoneProfileCell
        
        cell.threadLabel.text = model[indexPath.row]
        if indexPath.row%2==0{
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
