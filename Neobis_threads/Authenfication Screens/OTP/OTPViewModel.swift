//
//  OTPViewModel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 4/9/23.
//

import Foundation
import UIKit

protocol OTPProtocol {
    var isOTPIn: Bool { get }
    var otpResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func otp(email: String, otp: Int)
}

class OTPViewModel: OTPProtocol {
    
    var isOTPIn: Bool = false
    var otpResult: ((Result<Data, Error>) -> Void)?
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    func otp(email : String, otp: Int) {
        let parameters: [String: Any] = ["email": email, "otp": otp]
        
        guard let token = AuthManager.shared.accessToken else { return }
        
        apiService.putWithToken(endpoint: "confirm_email/update/", parameters: parameters, token: token) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    self?.isOTPIn = true
                    self?.otpResult?(.success(data))
                    print(data)
                case .failure(let error):
                    let errorMessage = "Failed register number: \(error.localizedDescription)"
                    print(errorMessage)
                    self?.isOTPIn = false
                    self?.otpResult?(.failure(error))
                    print(error)
                }
            }
        }
    }
}
