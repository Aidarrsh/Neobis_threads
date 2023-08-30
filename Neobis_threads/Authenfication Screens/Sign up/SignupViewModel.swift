//
//  SignupViewModel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 26/8/23.
//

import Foundation
import UIKit

protocol SignUpProtocol {
    var isRegistered: Bool { get }
    var registerResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func register(email: String, username: String, password: String, password2: String)
}

class SignUpViewModel: SignUpProtocol {
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    var isRegistered: Bool = false
    
    var registerResult: ((Result<Data, Error>) -> Void)?
    
    func register(email: String, username: String, password: String, password2: String) {
        
        let parameters: [String: Any] = ["email": email, "username": username, "password": password, "password2": password2]
        
        // Check email format
        if !isValidEmail(email) {
            let error = NSError(domain: "Invalid email format", code: 400, userInfo: nil)
            print("Error: \(error)")
            registerResult?(.failure(error))
            print(error)
        }

        
        // Check password format
        if !isValidPassword(password) {
            let error = NSError(domain: "Invalid password format", code: 400, userInfo: nil)
            registerResult?(.failure(error))
            print(error)

        }
        
        if password != password2 {
            let error = NSError(domain: "Passwords are not same", code: 400, userInfo: nil)
            registerResult?(.failure(error))
            print(error)

        }
        
        // Perform registration API call
        // Replace this with your actual API call implementation
        apiService.post(endpoint: "api/v1/sign_up/", parameters: parameters) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let dataString = String(data: data, encoding: .utf8)
                    print("Data received: \(dataString ?? "nil")")
                    self?.isRegistered = true
                    self?.registerResult?(.success(data))
                    print(data)
                case .failure(let error):
                    let errorMessage = "Failed register number: \(error.localizedDescription)"
                    print(errorMessage)
                    self?.registerResult?(.failure(error))
                    print(error)
                }
            }
            
        }
    }
    
    // Email validation function
    private func isValidEmail(_ email: String) -> Bool {
        return email.lowercased().contains("@gmail.com")
    }
    
    // Password validation function
    private func isValidPassword(_ password: String) -> Bool {

        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        return passwordTest.evaluate(with: password)
    }
}
