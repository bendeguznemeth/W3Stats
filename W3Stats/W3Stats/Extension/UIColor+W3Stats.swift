//
//  UIColor+W3Stats.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 25..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

extension UIColor {
    
}

enum W3StatsTextColor {
    case white
    case black
    case yellow
    
    var value: UIColor {
        switch self {
        case .white:
            return UIColor.white
        case .black:
            return UIColor.black
        case .yellow:
            return UIColor(red: 1.00, green: 0.94, blue: 0.44, alpha: 1.0)
        }
    }
}
