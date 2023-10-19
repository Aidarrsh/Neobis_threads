//
//  ThreadViewModel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 28/9/23.
//

import Foundation

protocol ThreadProtocol {
    var isLiked: Bool { get }
    var setLikeResult: (((Result<Data, Error>)) -> Void)? { get set }
    var commentsList: (([Comment]) -> Void)? { get set }
    
    func fetchUserData(completion: @escaping (Result<[String: Any], Error>) -> Void)
    func fetchPostData(id: Int, completion: @escaping (Post?) -> Void)
    func fetchCommentsData(id: Int, completion: @escaping ([Comment]) -> Void)
    func fetchSearchData(id: Int, completion: @escaping (UserData?) -> Void)
    func fetchlikeData(id: Int)
}

class ThreadViewModel: ThreadProtocol {
    
    let apiService: APIService
    var isLiked: Bool = false
    var setLikeResult: ((Result<Data, Error>) -> Void)?
    var commentsList: (([Comment]) -> Void)?
    
    init() {
        self.apiService = APIService()
    }
    
    func fetchPostData(id: Int, completion: @escaping (Post?) -> Void) {
        let endpoint = "post/\(id)/view/"
        let accessToken = AuthManager.shared.accessToken
        
        apiService.getWithToken(endpoint: endpoint, token: accessToken) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let user = try decoder.decode(Post.self, from: data)
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
    
    func fetchCommentsData(id: Int, completion: @escaping ([Comment]) -> Void) {
        let endpoint = "post/\(id)/comments/"
        let accessToken = AuthManager.shared.accessToken

        apiService.getWithToken(endpoint: endpoint, token: accessToken) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let response = try decoder.decode(CommentResponse.self, from: data)
                    let comments = response.results
                    completion(comments)
                } catch {
                    print("Error decoding JSON:", error)
                }
            case .failure(let error):
                print("API request failed:", error)
            }
        }
    }
}
