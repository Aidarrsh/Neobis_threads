//
//  Extensions + Data.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 26/9/23.
//

import Foundation

import Foundation

extension Data {
    
    mutating public func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}
