//
//  ProfileViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 12/8/23.
//

import SnapKit
import UIKit

class ProfileViewController: UIViewController {
    
    private let contentView = ProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
        setupView()
    }
    
    func setupView() {
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTargets() {
        contentView.editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
    
    @objc func editButtonTapped() {
        let vc = EditProfileViewController()
        
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
