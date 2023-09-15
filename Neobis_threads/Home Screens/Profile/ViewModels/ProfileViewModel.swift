//
//  ProfileViewModel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 3/9/23.
//

import Foundation
import Alamofire

protocol ProfileProtocol {
    func fetchUserData(completion: @escaping (Result<[String: Any], Error>) -> Void)
}

class ProfileViewModel: ProfileProtocol {
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    func fetchUserData(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        
        guard let token = AuthManager.shared.accessToken else { return }
        print(token)
//        print(AuthManager.shared.refreshToken)
        
        apiService.getWithToken(endpoint: "user/profile/me/", token: token) { result in
            switch result {
            case .success(let data):
                do {
                    if let userData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        completion(.success(userData))
                    } else {
                        let error = NSError(domain: "UserDataParsingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse user data"])
                        completion(.failure(error))
                    }
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

