//
//  ProfileViewModel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 3/9/23.
//

import Foundation
import Alamofire

protocol ProfileProtocol {
    var feedsList: (([Post]) -> Void)? { get set }
    var isLiked: Bool { get }
    var setLikeResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func fetchUserData(completion: @escaping (Result<[String: Any], Error>) -> Void)
    func fetchFeedsData(completion: @escaping ([Post]) -> Void)
    func fetchlikeData(id: Int)
    func fetchDeleteData(id: Int)
}

class ProfileViewModel: ProfileProtocol {
    var feedsList: (([Post]) -> Void)?
    var isLiked: Bool = false
    var setLikeResult: ((Result<Data, Error>) -> Void)?
    
    let apiService: APIService
    
    init() {
        self.apiService = APIService()
    }
    
    func fetchUserData(completion: @escaping (Result<[String: Any], Error>) -> Void) {
        
        guard let token = AuthManager.shared.accessToken else { return }
        print(token)
        
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
    
    func fetchFeedsData(completion: @escaping ([Post]) -> Void) {
        guard let accessToken = AuthManager.shared.accessToken else { return }
        
        let endpoint = "post/"
        
        apiService.getWithToken(endpoint: endpoint, token: accessToken) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let response = try decoder.decode(PostResponse.self, from: data)
                    let feeds = response.results.map { Post(id: $0.id, author: $0.author, text: $0.text, date_posted: $0.date_posted, image: $0.image, video: $0.video, comments_permission: $0.comments_permission, total_likes: $0.total_likes, total_comments: $0.total_comments, user_like: $0.user_like) }
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
    func fetchDeleteData(id: Int) {
        let endpoint = "post/\(id)/"
        let accessToken = AuthManager.shared.accessToken
        
        apiService.deletePost(endpoint: endpoint, token: accessToken) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    let decoder = JSONDecoder()
//                    self?.isLiked = true
//                    self?.setLikeResult?(.success(data))
                    print(data)
                case .failure(let error):
                    let errorMessage = "Failed to like: \(error.localizedDescription)"
                    print(errorMessage)
//                    self?.isLiked = false
//                    self?.setLikeResult?(.failure(error))
                }
            }
        }
    }
    
}

