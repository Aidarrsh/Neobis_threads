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
    
    var someoneProfileProtocol: SomeoneProfileProtocol
    var userId: Int
    var isShareButtonPressed = false
    
    init(someoneProfileProtocol: SomeoneProfileProtocol, userId: Int) {
        self.someoneProfileProtocol = someoneProfileProtocol
        self.userId = userId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addTargets()
        setupTapGesture()
        parseData()
    }
    
    func parseData() {
        someoneProfileProtocol.fetchSearchData(id: userId) { userData in
            DispatchQueue.main.async {
                self.contentView.professionLabel.text = userData?.username
                self.contentView.nicknameLabel.text = userData?.full_name
                
                if let photoURLString = userData?.photo, let photoURL = URL(string: photoURLString) {
                    self.contentView.profilePicture.kf.setImage(with: photoURL, placeholder: nil, options: [.transition(.fade(0.2))], progressBlock: nil) { result in
                    }
                }
            }
        }
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

