//
//  SomeoneProfileViewModel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 28/9/23.
//

import Foundation
protocol SomeoneProfileProtocol {
    var isFollowed: Bool { get }
    var isMutual: Bool { get }
    var setDataResult: ((Result<Data, Error>) -> Void)? { get set }
    var setMutualResult: ((Result<(MutualFollowStatus, String), Error>) -> Void)? { get set }
    var feedsList: (([Post]) -> Void)? { get set }
    var isLiked: Bool { get }
    var setLikeResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func fetchFollowData(id: Int)
    func fetchMutualData(followee: Int)
    func fetchSearchData(id: Int, completion: @escaping (UserData?) -> Void)
    func fetchFeedsData(id: Int, completion: @escaping ([Post]) -> Void)
    func fetchlikeData(id: Int)
}

class SomeoneProfileViewModel: SomeoneProfileProtocol {
    var isLiked: Bool = false
    
    var setLikeResult: ((Result<Data, Error>) -> Void)?
    
    
    let apiService: APIService
    
    var feedsList: (([Post]) -> Void)?
    var isFollowed: Bool = false
    var isMutual: Bool = false
    var setDataResult: ((Result<Data, Error>) -> Void)?
    var setMutualResult: ((Result<(MutualFollowStatus, String), Error>) -> Void)?
    
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
                case .failure(let error):
                    let errorMessage = "Failed to follow: \(error.localizedDescription)"
                    print(errorMessage)
                    self?.isFollowed = false
                    self?.setDataResult?(.failure(error))
                }
            }
        }
    }
    
    func fetchMutualData(followee: Int) {
        let endpoint = "user/profile/mutual_follow/"
        
        let parameters: [String: Any] = ["followee": followee]
        
        guard let token = AuthManager.shared.accessToken else { return }
        
        apiService.postWithToken(endpoint: endpoint, parameters: parameters, token: token) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    self?.isMutual = true
                    let status: MutualFollowStatus = .mutualFollow
                    
                    if let responseString = String(data: data, encoding: .utf8) {
                        self?.setMutualResult?(.success((status, responseString)))
                    } else {
                        print("Failed to convert data to string")
                    }
                case .failure(let error):
                    let errorMessage = "Failed to follow: \(error.localizedDescription)"
                    print(errorMessage)
                    self?.isMutual = false
                    self?.setMutualResult?(.failure(error))
                    print(error)
                }
            }
        }
    }
    
    func fetchFeedsData(id: Int, completion: @escaping ([Post]) -> Void) {
        guard let accessToken = AuthManager.shared.accessToken else { return }
        
        let endpoint = "post/\(id)/list/"
        
        apiService.getWithToken(endpoint: endpoint, token: accessToken) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let feeds = try decoder.decode([Post].self, from: data)
                    self.feedsList?(feeds)
                    completion(feeds)
                } catch {
                    print("Error decoding JSON:", error)
                }
            case .failure(let error):
                print("API request failed:", error)
            }
        }
    }
    
    func fetchlikeData(id: Int) {
        let endpoint = "post/like_unlike/\(id)/"
        let accessToken = AuthManager.shared.accessToken
        
        apiService.patchLike(endpoint: endpoint, token: accessToken) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
                    self?.isLiked = true
                    self?.setLikeResult?(.success(data))
                    print(data)
                case .failure(let error):
                    let errorMessage = "Failed to like: \(error.localizedDescription)"
                    print(errorMessage)
                    self?.isLiked = false
                    self?.setLikeResult?(.failure(error))
                    print(error)
                }
            }
        }
    }
}
