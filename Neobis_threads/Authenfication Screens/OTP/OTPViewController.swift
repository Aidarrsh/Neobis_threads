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
    
    var otpProtocol: OTPProtocol
    var email: String?
    
    init(otpProtocol: OTPProtocol, email: String?) {
        self.otpProtocol = otpProtocol
        self.email = email
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        guard let codeText = contentView.otpTextField.text else { return }
        
        if let code = Int(codeText) {
            otpProtocol.otp(email: email ?? "nil" , otp: code)
        } else {
            print("wrong code type")
        }
        
        otpProtocol.otpResult = { [weak self] result in
            switch result {
            case .success:
                DispatchQueue.main.async {
                    let vc = TabBarController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true, completion: nil)
                }
            case .failure(let error):
                print("Login failed with error: \(error)")
                
                self?.showErrorAlert(message: "Введены неверные данные. Попробуйте еще раз.")
            }
        }
    }
    
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Неверные данные", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
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
