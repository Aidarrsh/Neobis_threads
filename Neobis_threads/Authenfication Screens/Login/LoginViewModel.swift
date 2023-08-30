//
//  LoginViewModel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 26/8/23.
//

import Foundation
import UIKit

protocol LoginProtocol {
    var isLoggedIn: Bool { get }
    var loginResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func login(email: String, password: String)
}

class LoginViewModel: LoginProtocol {
    
    var isLoggedIn: Bool = false
    var loginResult: ((Result<Data, Error>) -> Void)?
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    func login(email: String, password: String) {
        let parameters: [String: Any] = ["email": email, "password": password]
        
        apiService.post(endpoint: "api/v1/sign_in/", parameters: parameters) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    let dataString = String(data: data, encoding: .utf8)
                    print("Data received: \(dataString ?? "nil")")
                    self?.isLoggedIn = true
                    self?.loginResult?(.success(data))
                case .failure(let error):
                    let errorMessage = "Failed register number: \(error.localizedDescription)"
                    print(errorMessage)
                    self?.isLoggedIn = false
                    self?.loginResult?(.failure(error))
                }
            }
        }
    }
}

