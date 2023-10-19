//
//  ActivityModel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 8/10/23.
//

import Foundation

struct ActivityModel: Codable {
    let pk: Int
    let owner: Int
    let text: String
    let related_user: Int?
    let related_post: Int?
    let relatedComment: Int?
    let datePosted: Date
    
    enum CodingKeys: String, CodingKey {
        case pk, owner, text, related_user, related_post, relatedComment, datePosted = "date_posted"
    }
}

struct FollowsResponse: Codable {
    let count: Int
    let results: [ActivityModel]
}
