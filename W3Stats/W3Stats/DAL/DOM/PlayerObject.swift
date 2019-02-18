//
//  PlayerObject.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 08..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import RealmSwift

class PlayerObject: Object {
    @objc dynamic var name = ""
    @objc dynamic var stats: StatsObject? = nil
    @objc dynamic var race = ""
    var raceEnum: Race {
        get {
            return Race(rawValue: race)
        }
        set {
            race = newValue.rawValue
        }
    }
    
    override class func primaryKey() -> String? {
        return "name"
    }
}
