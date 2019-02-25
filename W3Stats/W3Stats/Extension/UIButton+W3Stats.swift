//
//  UIButton+W3Stats.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 25..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

extension UIButton {
    
    func setupWithFont(_ font: W3StatsFont, withSize size: W3StatsFontSize, withColor color: W3StatsTextColor) {
        self.titleLabel?.font = UIFont(name: font.rawValue, size: size.rawValue)
        self.setTitleColor( color.value, for: .normal)
    }
    
}
