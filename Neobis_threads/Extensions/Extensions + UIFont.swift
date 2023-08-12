//
//  Extensions + UIFont.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 9/8/23.
//

import Foundation
import UIKit

extension UIFont {
    static func sfRegular(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "SFProDisplay-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func sfBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "SFProDisplay-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    
    static func sfSemiBold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "SFProDisplay-SemiBold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    
    static func sfMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "SFProDisplay-Medium", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}
