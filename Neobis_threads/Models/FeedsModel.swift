//
//  FeedsModel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 15/9/23.
//

import Foundation

struct Post: Codable {
    let id: Int
    let author: Int
    let text: String
    let date_posted: String
    let image: String?
    let video: String?
//    let repost: String? // You may want to replace String with the appropriate type if this represents another post.
    let comments_permission: String
    let total_likes: Int
    let user_like: Bool
}

struct PostResponse: Codable {
    let count: Int
    let results: [Post]
}

struct Links: Codable {
    let next: String?
    let previous: String?
}
