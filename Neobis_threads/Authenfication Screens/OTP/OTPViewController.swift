//
//  OTPVC.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 9/8/23.
//

import SnapKit
import UIKit
import AEOTPTextField

class OTPViewController: UIViewController {
    
    private let contentView = OTPView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOTPTextField()
        addTargets()
        setupView()
    }
    
    func addTargets() {
        contentView.verifyButton.addTarget(self, action: #selector(verifyButtonTapped), for: .touchUpInside)
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
    
    @objc func verifyButtonTapped() {
        print(contentView.otpTextField.text ?? "")
    }
}

extension OTPViewController: AEOTPTextFieldDelegate {
    func didUserFinishEnter(the code: String) {
        return
    }
    
    func configureOTPTextField() {
        contentView.otpTextField.otpDelegate = self
        contentView.otpTextField.configure(with: 4)
        contentView.otpTextField.otpFilledBorderColor = UIColor(named: "GreyBorder") ?? .gray
        contentView.otpTextField.otpDefaultBorderColor = UIColor(named: "GreyBorder") ?? .gray
    }
}
