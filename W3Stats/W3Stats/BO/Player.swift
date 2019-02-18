//
//  Player.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 08..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

class Player {
    
    let name: String
    let race: Race
    let stats: Stats
    
    init(name: String, race: Race, stats: Stats) {
        self.name = name
        self.race = race
        self.stats = stats
    }
    
    convenience init?(name: String, race: Race, stats: Stats?) {
        guard let stats = stats else {
            return nil
        }
        
        self.init(name: name, race: race, stats: stats)
    }
}
