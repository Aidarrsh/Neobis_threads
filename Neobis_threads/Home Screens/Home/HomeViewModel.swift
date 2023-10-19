//
//  HomeViewModel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 15/9/23.
//

import Foundation
import Alamofire

protocol HomeProtocol {
    var forYouFeedsList: (([Post]) -> Void)? { get set }
    var followingFeedsList: (([Post]) -> Void)? { get set }
    var usersResult: ((UserData) -> Void)? { get set }
    var isLiked: Bool { get }
    var setLikeResult: ((Result<Data, Error>) -> Void)? { get set }
    
    func fetchForYouFeedsData(completion: @escaping ([Post]) -> Void)
    func fetchFollowingFeedsData(completion: @escaping ([Post]) -> Void)
    func fetchSearchData(id: Int, completion: @escaping (UserData?) -> Void)
    func fetchlikeData(id: Int)
}

class HomeViewModel: HomeProtocol {
    
    let apiService: APIService
    
    var isLiked: Bool = false
    var setLikeResult: ((Result<Data, Error>) -> Void)?
    
    var forYouFeedsList: (([Post]) -> Void)?
    var followingFeedsList: (([Post]) -> Void)?
    var usersResult: ((UserData) -> Void)?
    
    init() {
        self.apiService = APIService()
    }
    
    func fetchForYouFeedsData(completion: @escaping ([Post]) -> Void) {
        guard let accessToken = AuthManager.shared.accessToken else { return }
        
        let endpoint = "feed/for_you/?page_size=50"
        
        apiService.getWithToken(endpoint: endpoint, token: accessToken) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let response = try decoder.decode(PostResponse.self, from: data)
                    let feeds = response.results.map { Post(id: $0.id, author: $0.author, text: $0.text, date_posted: $0.date_posted, image: $0.image, video: $0.video, comments_permission: $0.comments_permission, total_likes: $0.total_likes, total_comments: $0.total_comments, user_like: $0.user_like) }
                    self.forYouFeedsList?(feeds)
                    completion(feeds)
                } catch {
                    print("Error decoding JSON:", error)
                }
            case .failure(let error):
                print("API request failed:", error)
            }
        }
    }
    
    func fetchFollowingFeedsData(completion: @escaping ([Post]) -> Void) {
        guard let accessToken = AuthManager.shared.accessToken else { return }
        
        let endpoint = "feed/following/?page_size=50"
        
        apiService.getWithToken(endpoint: endpoint, token: accessToken) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let response = try decoder.decode(PostResponse.self, from: data)
                    let feeds = response.results.map { Post(id: $0.id, author: $0.author, text: $0.text, date_posted: $0.date_posted, image: $0.image, video: $0.video, comments_permission: $0.comments_permission, total_likes: $0.total_likes, total_comments: $0.total_comments, user_like: $0.user_like) }
                    self.forYouFeedsList?(feeds)
                    completion(feeds)
                } catch {
                    print("Error decoding JSON:", error)
                }
            case .failure(let error):
                print("API request failed:", error)
            }
        }
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
