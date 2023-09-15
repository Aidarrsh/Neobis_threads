//
//  TokenModel.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 3/9/23.
//

import Foundation

struct TokenResponse: Codable {
    let access: String
    let refresh: String
}
