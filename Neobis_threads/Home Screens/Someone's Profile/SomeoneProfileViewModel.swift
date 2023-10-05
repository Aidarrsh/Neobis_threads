//
//  SomeoneProfileViewModel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 28/9/23.
//

import Foundation
protocol SomeoneProfileProtocol {
    func fetchSearchData(id: Int, completion: @escaping (UserData?) -> Void)
    
    var isFollowed: Bool { get }
    var setDataResult: ((Result<Data, Error>) -> Void)? { get set }
    func fetchFollowData(id: Int)
}

class SomeoneProfileViewModel: SomeoneProfileProtocol {
    
    let apiService: APIService
    
    var isFollowed: Bool = false
    var setDataResult: ((Result<Data, Error>) -> Void)?
    
    init() {
        self.apiService = APIService()
    }
    
    func fetchSearchData(id: Int, completion: @escaping (UserData?) -> Void) {
        let endpoint = "user/profile/\(id)/"
        let accessToken = AuthManager.shared.accessToken
        
        apiService.getWithToken(endpoint: endpoint, token: accessToken) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(UserData.self, from: data)
                    completion(user)
                } catch {
                    print("Error decoding JSON:", error)
                    completion(nil)
                }
            case .failure(let error):
                print("API request failed:", error)
                completion(nil)
            }
        }
    }
    
    func fetchFollowData(id: Int) {
        let endpoint = "user/profile/follow/"
        
        let parameters: [String: Any] = ["followee": id]
        
        guard let token = AuthManager.shared.accessToken else { return }
        
        apiService.postWithToken(endpoint: endpoint, parameters: parameters, token: token) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    self?.isFollowed = true
                    self?.setDataResult?(.success(data))
                    print(data)
                case .failure(let error):
                    let errorMessage = "Failed to follow: \(error.localizedDescription)"
                    print(errorMessage)
                    self?.isFollowed = false
                    self?.setDataResult?(.failure(error))
                    print(error)
                }
            }
        }
    }
}
