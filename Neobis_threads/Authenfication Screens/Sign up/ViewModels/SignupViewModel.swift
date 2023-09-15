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
        
        apiService.post(endpoint: "sign_up/", parameters: parameters) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    if let tokenResponse = try? decoder.decode(TokenResponse.self, from: data) {
                        AuthManager.shared.accessToken = tokenResponse.access
                        print(tokenResponse.access)
                        
                        self?.isRegistered = true
                        self?.registerResult?(.success(data))
                    }
                case .failure(let error):
                    let errorMessage = "Failed register number: \(error)"
                    print(errorMessage)
                    self?.registerResult?(.failure(error))
                    print(error)
                }
            }
            
        }
    }
}
