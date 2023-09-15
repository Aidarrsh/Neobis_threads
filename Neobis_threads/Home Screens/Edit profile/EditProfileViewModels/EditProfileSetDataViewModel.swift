//
//  EditProfileSetData.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 3/9/23.
//

import Foundation
import UIKit

protocol SetProfileDataProtocol {
    var isSetData: Bool { get }
    var setDataResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func setData(username: String, full_name: String, bio: String, website: String)
}

class EditProfileSetDataViewModel: SetProfileDataProtocol {
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    var isSetData: Bool = false
    
    var setDataResult: ((Result<Data, Error>) -> Void)?
    
    func setData(username: String, full_name: String, bio: String, website: String) {
        
        let parameters: [String: Any] = ["username": username, "full_name": full_name, "bio": bio, "website": website]
        
        guard let token = AuthManager.shared.accessToken else { return }
        
        apiService.patch(endpoint: "user/profile/update/", token: token, parameters: parameters) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let dataString = String(data: data, encoding: .utf8)
                    print("Data received: \(dataString ?? "nil")")
                    self?.isSetData = true
                    self?.setDataResult?(.success(data))
                    print(data)
                case .failure(let error):
                    let errorMessage = "Failed setData number: \(error)"
                    print(errorMessage)
                    self?.setDataResult?(.failure(error))
                    print(error)
                }
            }
            
        }
    }
}
