//
//  FollowersViewModel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 12/10/23.
//

import Foundation

protocol FollowersProtocol {
    var followsList: (([Followee]) -> Void)? { get set }
    var followersList: (([Followee]) -> Void)? { get set }
    var isMutual: Bool { get }
    var setMutualResult: ((Result<(MutualFollowStatus, String), Error>) -> Void)? { get set }
    var isFollowed: Bool { get }
    var setDataResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func followsFetchData(id: Int, completion: @escaping ([Followee]) -> Void)
    func followersFetchData(id: Int, completion: @escaping ([Followee]) -> Void)
    func fetchMutualData(followee: Int)
    func fetchFollowData(id: Int)
}

class FollowersViewModel: FollowersProtocol {
    
    var isFollowed: Bool = false
    var setDataResult: ((Result<Data, Error>) -> Void)?
    var isMutual: Bool = false
    var setMutualResult: ((Result<(MutualFollowStatus, String), Error>) -> Void)?
    var followsList: (([Followee]) -> Void)?
    var followersList: (([Followee]) -> Void)?
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    func followsFetchData(id: Int, completion: @escaping ([Followee]) -> Void) {
        guard let accessToken = AuthManager.shared.accessToken else { return }
        
        let endpoint = "user/profile/follows/\(id)/"
        
        apiService.getWithToken(endpoint: endpoint, token: accessToken) { result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dict = json as? [String: Any], let results = dict["results"] as? [[String: Any]] {
                        let followees = results.compactMap { dict in
                            return dict["followee"] as? [String: Any]
                        }
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let response = try decoder.decode([Followee].self, from: JSONSerialization.data(withJSONObject: followees, options: []))
                        self.followsList?(response)
                        completion(response)
                    }
                } catch {
                    print("Error decoding JSON:", error)
                }
            case .failure(let error):
                print("API request failed:", error)
            }
        }
    }
    
    func followersFetchData(id: Int, completion: @escaping ([Followee]) -> Void) {
        guard let accessToken = AuthManager.shared.accessToken else { return }
        
        let endpoint = "user/profile/followers/\(id)/"
        
        apiService.getWithToken(endpoint: endpoint, token: accessToken) { result in
            switch result {
            case .success(let data):
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    if let dict = json as? [String: Any], let results = dict["results"] as? [[String: Any]] {
                        let followees = results.compactMap { dict in
                            return dict["follower"] as? [String: Any]
                        }
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .iso8601
                        let response = try decoder.decode([Followee].self, from: JSONSerialization.data(withJSONObject: followees, options: []))
                        self.followsList?(response)
                        completion(response)
                    }
                } catch {
                    print("Error decoding JSON:", error)
                }
            case .failure(let error):
                print("API request failed:", error)
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
}
