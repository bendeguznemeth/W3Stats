//
//  StatsUtil.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 19..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

struct Stat {
    let wins: Int
    let losses: Int
    let total: Int
    let percentage: Int
}

struct StatsUtil {
    
    static func calculateStat(wins: Int, losses: Int) -> Stat {
        let total = wins + losses
        var percentage = 100.0
        
        if total != 0 {
            percentage = Double(wins) / Double(total) * 100
        } else {
            percentage = 100.0
        }
        
        return Stat(wins: wins, losses: losses, total: total, percentage: Int(percentage))
    }
    
}
