//
//  Extensions + String.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 3/10/23.
//

import Foundation

extension String {
    func countOccurences(of searchString: String, in range: NSRange) -> Int {
        let substring = (self as NSString).substring(with: range)
        return substring.components(separatedBy: searchString).count - 1
    }
}
