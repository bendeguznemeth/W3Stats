//
//  Player.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 08..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

class Player {
    let name: String
    let species: Species
    let stats: Stats
    
    init(name: String, species: Species, stats: Stats) {
        self.name = name
        self.species = species
        self.stats = stats
    }
}
