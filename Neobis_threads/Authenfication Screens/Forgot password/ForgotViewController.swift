//
//  ForgotVC.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 8/8/23.
//

import SnapKit
import UIKit

class ForgotViewController: UIViewController {
    
    private let contentView = ForgotView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addTargets()
        setupView()
    }
    
    func addTargets() {
        contentView.continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    func setupView() {
        
        let backButton = UIBarButtonItem(image: UIImage(named: "BackIcon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backPressed))
        self.navigationItem.leftBarButtonItem = backButton
        
        view.addSubview(contentView)
        
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func backPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func continueButtonTapped() {
        
        guard let email = contentView.emailField.text else { return }
        
        let vc = OTPViewController(otpProtocol: OTPViewModel(), email: email)
        
        navigationController?.pushViewController(vc, animated: true)
    }
}
