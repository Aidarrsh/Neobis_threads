//
//  CustomBottomShareSheet.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 1/9/23.
//

import Foundation
import UIKit
import SnapKit

class CustomBottomShareSheet: UIView {
    
    let copyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Copy link", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.sfRegular(ofSize: 15)
        button.backgroundColor = UIColor(named: "GreyTextField")
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        
        button.titleEdgeInsets = UIEdgeInsets(top: 44, left: 0, bottom: 10, right: 0)
        button.contentHorizontalAlignment = .center
        
        return button
    }()

    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share via...", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.sfRegular(ofSize: 15)
        button.backgroundColor = UIColor(named: "GreyTextField")
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        
        button.titleEdgeInsets = UIEdgeInsets(top: 44, left: 0, bottom: 10, right: 0)
        button.contentHorizontalAlignment = .center
        
        return button
    }()
    
    let blockButton: UIButton = {
        let button = UIButton()
        button.setTitle("Block", for: .normal)
        button.setTitleColor(.systemRed, for: .normal)
        button.titleLabel?.font = UIFont.sfSemiBold(ofSize: 17)
        button.backgroundColor = UIColor(named: "GreyTextField")
        button.layer.cornerRadius = 8 * UIScreen.main.bounds.height / 852
        
        button.titleEdgeInsets = UIEdgeInsets(top: 11, left: 16, bottom: 11, right: 0)
        button.contentHorizontalAlignment = .fill
        
        return button
    }()
    
    let PinIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "PinIcon")
        
        return image
    }()
    
    let ShareIcon: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "ShareIcon 1")
        
        return image
    }()
    
    override func layoutSubviews() {
        backgroundColor = UIColor(named: "ScreenBackground")
        layer.cornerRadius = 12 * UIScreen.main.bounds.height / 852
        addSubview(copyButton)
        addSubview(shareButton)
        addSubview(PinIcon)
        addSubview(ShareIcon)
        addSubview(blockButton)
        
        copyButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 32))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 203))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 101))
        }
        
        shareButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 32))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 203))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.bottom.equalToSuperview().inset(flexibleHeight(to: 101))
        }
        
        blockButton.snp.makeConstraints{ make in
            make.top.equalToSuperview().inset(flexibleHeight(to: 124))
            make.leading.equalToSuperview().inset(flexibleWidth(to: 16))
            make.trailing.equalToSuperview().inset(flexibleWidth(to: 16))
            make.height.equalTo(flexibleHeight(to: 44))
        }
        
        PinIcon.snp.makeConstraints{ make in
            make.top.equalTo(copyButton.snp.top).inset(flexibleHeight(to: 10))
            make.leading.equalTo(copyButton.snp.leading).inset(flexibleWidth(to: 75))
            make.trailing.equalTo(copyButton.snp.trailing).inset(flexibleWidth(to: 75))
            make.bottom.equalTo(copyButton.snp.bottom).inset(flexibleHeight(to: 42))
        }
        
        ShareIcon.snp.makeConstraints{ make in
            make.top.equalTo(shareButton.snp.top).inset(flexibleHeight(to: 10))
            make.leading.equalTo(shareButton.snp.leading).inset(flexibleWidth(to: 75))
            make.trailing.equalTo(shareButton.snp.trailing).inset(flexibleWidth(to: 75))
            make.bottom.equalTo(shareButton.snp.bottom).inset(flexibleHeight(to: 42))
        }
    }
}

