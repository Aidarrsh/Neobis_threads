//
//  Extenions + NSObject.swift
//  Neobis_threads
//
//  Created by Айдар Шарипов on 8/8/23.
//

import Foundation
import UIKit

extension NSObject {
    func flexibleHeight(to: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.height * to / 852
    }
    func flexibleWidth(to: CGFloat) -> CGFloat {
        return UIScreen.main.bounds.width * to / 393
    }
    
}
