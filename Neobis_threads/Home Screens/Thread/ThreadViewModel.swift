//
//  ThreadViewModel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 28/9/23.
//

import Foundation

protocol ThreadProtocol {
    func fetchPostData(id: Int, completion: @escaping (Post?) -> Void)
    func fetchSearchData(id: Int, completion: @escaping (UserData?) -> Void)
}

class ThreadViewModel: ThreadProtocol {
    
    let apiService: APIService
    
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
}
