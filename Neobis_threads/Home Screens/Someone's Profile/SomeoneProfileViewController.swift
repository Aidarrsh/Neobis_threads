//
//  SomeoneProfileViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 1/9/23.
//

import SnapKit
import UIKit

class SomeoneProfileViewController: UIViewController {
    
    private let contentView = SomeoneProfileView()
    
    var isShareButtonPressed = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addTargets()
        setupTapGesture()
//        navigationItem.hidesBackButton = true
    }
    
    func setupView() {
        
        let backButton = UIBarButtonItem(image: UIImage(named: "BackIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        let shareButton = UIBarButtonItem(image: UIImage(named: "ShareIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(shareButtonPressed))
        self.navigationItem.rightBarButtonItem = shareButton
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTargets() {
    }
    
    func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOutside(_:)))
        tapGesture.cancelsTouchesInView = false
        contentView.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handleTapOutside(_ sender: UITapGestureRecognizer) {
        if isShareButtonPressed == true {
            let location = sender.location(in: contentView.bottomSheet)
            
            if !contentView.bottomSheet.bounds.contains(location) {
                if sender.state == .ended {
                    contentView.dismissBottomSheet()
                    isShareButtonPressed = false
                }
            }
        }
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func shareButtonPressed() {
        if isShareButtonPressed == false{
            contentView.presentBottomSheet()
            isShareButtonPressed = true
        }
    }
}

