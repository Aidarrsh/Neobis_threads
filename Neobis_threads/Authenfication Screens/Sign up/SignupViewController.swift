//
//  SignupViewController.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 11/8/23.
//

import SnapKit
import UIKit

class SignupViewController: UIViewController {
    
    private let contentView = SignupView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
        setupView()
    }
    
    func addTargets() {
        contentView.createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
    }
    
    func setupView() {
        
        let backButton = UIBarButtonItem(image: UIImage(named: "BackIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func createAccountButtonTapped() {
        let vc = PasswordViewController()
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
}
