//
//  PlayerWithStats.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 13..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

class PlayerWithStats: Player {
    let stats: Stats
    
    init(name: String, species: Species, stats: Stats) {
        self.stats = stats
        super.init(name: name, species: species)
    }
}
