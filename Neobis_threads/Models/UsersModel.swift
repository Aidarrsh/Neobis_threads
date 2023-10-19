//
//  UsersModel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 4/9/23.
//

import Foundation

class UsersList: Codable {
    var pk: Int
    var username: String
    var full_name: String?
    var bio: String?
    var website: String?
    var photo: String?
    var is_followed: String
    
    init(pk: Int, username: String, is_followed: String) {
            self.pk = pk
            self.username = username
//            self.bio = bio
//            self.full_name = full_name
            self.is_followed = is_followed
//            self.photo = photo
//            self.website = website
        }
}

struct SearchResponse: Codable {
    var results: [UserResponse]

    struct UserResponse: Codable {
        var pk: Int
        var username: String
        var is_followed: String

        enum CodingKeys: String, CodingKey {
            case pk
            case username
            case is_followed = "is_followed"
        }
    }
}

struct SearchedUser: Codable {
    var pk: Int
    var username: String
    var full_name: String
    var bio: String
    var website: String
    var photo: String
}

struct Users: Codable {
    var users: [UserData]
}

struct UserData: Codable {
    var pk: Int
    var username: String
    var full_name: String?
    var bio: String?
    var website: String?
    var photo: String?
}

enum MutualFollowStatus {
    case pending
    case followed
    case notFollowed
    case mutualFollow
}

struct Followee: Codable {
    let pk: Int
    let username: String
    let full_name: String?
    let bio: String?
    let website: String?
    let location: String?
    let photo: String?
    let is_private: Bool
    let is_followed: String?
}
