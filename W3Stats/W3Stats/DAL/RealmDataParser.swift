//
//  RealmDataParser.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 18..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

class RealmDataParser {
    
    // MARK: BO from DOM
    
    static func playerFromPlayerObject(_ playerObject: PlayerObject?) -> Player? {
        guard let obj = playerObject else {
            return nil
        }
        
        let name = obj.name
        let race = obj.raceEnum
        let stats = statsFromStatsObject(obj.stats)
        
        return Player.init(name: name, race: race, stats: stats)
    }
    
    static func statsFromStatsObject(_ statsObject: StatsObject?) -> Stats? {
        let vsHuman = descFromDescObject(statsObject?.vsHuman)
        let vsElf = descFromDescObject(statsObject?.vsElf)
        let vsOrc = descFromDescObject(statsObject?.vsOrc)
        let vsUndead = descFromDescObject(statsObject?.vsUndead)
        
        return Stats.init(vsHuman: vsHuman, vsElf: vsElf, vsOrc: vsOrc, vsUndead: vsUndead)
    }
    
    static func descFromDescObject(_ descObjet: DescObject?) -> Desc? {
        guard let obj = descObjet else {
            return nil
        }
        
        let wins = obj.wins
        let losses = obj.losses
        
        return Desc.init(wins: wins, losses: losses)
    }
    
    // MARK: DOM from BO
    
    static func playerObjectFromPlayer(_ player: Player) -> PlayerObject {
        let playerObject = PlayerObject.init()
        playerObject.name = player.name
        playerObject.race = player.race.rawValue
        playerObject.stats = statsObjectFromStats(player.stats)

        return playerObject
    }
    
    static func statsObjectFromStats(_ stats: Stats) -> StatsObject {
        let statsObject = StatsObject.init()
        statsObject.vsHuman = descObjectFromDesc(stats.vsHuman)
        statsObject.vsElf = descObjectFromDesc(stats.vsElf)
        statsObject.vsOrc = descObjectFromDesc(stats.vsOrc)
        statsObject.vsUndead = descObjectFromDesc(stats.vsUndead)
        
        return statsObject
    }
    
    static func descObjectFromDesc(_ desc: Desc) -> DescObject {
        let descObject = DescObject.init()
        descObject.wins = desc.wins
        descObject.losses = desc.losses
        
        return descObject
    }
    
}
