//
//  UILabel+W3Stats.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 25..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import UIKit

extension UILabel {

    func setupWithFont(_ font: W3StatsFont, withSize size: W3StatsFontSize, withColor color: W3StatsTextColor) {
        self.font = UIFont(name: font.rawValue, size: size.rawValue)
        self.textColor = color.value
    }

}
