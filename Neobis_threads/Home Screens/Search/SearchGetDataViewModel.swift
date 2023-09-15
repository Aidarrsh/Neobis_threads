//
//  SearchGetDataViewModel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 11/9/23.
//

import Foundation
import Alamofire
import UIKit

protocol SearchDataProtocol {
    func fetchSearchData(username: String, completion: @escaping (String, String, String, String) -> Void)
    func fetchSearchData2(username: String)
    var usersResult: (([UsersList]) -> Void)? { get set }
    var usersList: [UsersList] { get set }
    
}

class SearchGetDataViewModel: SearchDataProtocol {
    let apiService: APIService
    
    var usersResult: (([UsersList]) -> Void)?
    var usersList = [UsersList]()
    var userData = [SearchedUser]()
    var users = [UsersList]()
    var bio = String()
    var full_name = String()
    var photo = String()
    var website = String()
    
    init() {
        self.apiService = APIService()
    }
    
    func fetchSearchData(username: String, completion: @escaping (String, String, String, String) -> Void) {
        guard let accessToken = AuthManager.shared.accessToken else { return }
        
        let endpoint = "user/profile/\(username)/"
        
        apiService.getWithToken(endpoint: endpoint, token: accessToken) { result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(SearchedUser.self, from: data)
                    
                    let bio = response.bio
                    let website = response.website
                    let photo = response.photo
                    let full_name = response.full_name
                    
                    completion(bio, website, photo, full_name)
                } catch {
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func fetchSearchData2(username: String) {
        guard let accessToken = AuthManager.shared.accessToken else { return }
        
        let endpoint = "search/users/\(username)/"
        
        apiService.getWithToken(endpoint: endpoint, token: accessToken) { [self] result in
            switch result {
            case .success(let data):
                do {
                    
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(SearchResponse.self, from: data)

                    let users = response.results.map { UsersList(pk: $0.pk, username: $0.username, is_followed: $0.is_followed) }
                    DispatchQueue.main.async {
                        for user in users {
                            self.fetchSearchData(username: user.username) { bio, website, photo, full_name in
                                user.bio = bio
                                user.website = website
                                user.photo = photo
                                user.full_name = full_name

                                self.usersResult?(users)
                            }
                        }
                        self.usersResult?(users)
                    }
                    
                } catch {
                    
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
