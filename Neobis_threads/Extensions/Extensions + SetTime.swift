//
//  Extensions + setTime.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 19/9/23.
//

import Foundation
import UIKit

extension UIViewController {
    func timeAgoSinceDate(dateString: String, numericDates: Bool = false) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSZ"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = formatter.date(from: dateString) else { return "" }
        
        let calendar = Calendar.current
        let now = Date()
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date, to: now)
        
        if let year = components.year, year >= 2 {
            return "\(year)y"
        } else if let year = components.year, year >= 1 {
            if numericDates {
                return "1y"
            } else {
                return "1y"
            }
        } else if let month = components.month, month >= 2 {
            return "\(month)m"
        } else if let month = components.month, month >= 1 {
            if numericDates {
                return "1m"
            } else {
                return "1m"
            }
        } else if let day = components.day, day >= 2 {
            return "\(day)d"
        } else if let day = components.day, day >= 1 {
            if numericDates {
                return "1d"
            } else {
                return "1d"
            }
        } else if let hour = components.hour, hour >= 2 {
            return "\(hour)h"
        } else if let hour = components.hour, hour >= 1 {
            if numericDates {
                return "1h"
            } else {
                return "1h"
            }
        } else if let minute = components.minute, minute >= 2 {
            return "\(minute)m"
        } else if let minute = components.minute, minute >= 1 {
            if numericDates {
                return "1m"
            } else {
                return "1m"
            }
        } else if let second = components.second, second >= 3 {
            return "\(second)s"
        } else {
            return "Just now"
        }
    }
}
