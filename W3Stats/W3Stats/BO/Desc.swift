//
//  Desc.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 08..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

class Desc {
    var wins: Int
    var losses: Int
    
    init(wins: Int, losses: Int) {
        self.wins = wins
        self.losses = losses
    }
    
    convenience init() {
        self.init(wins: 0, losses: 0)
    }
}
