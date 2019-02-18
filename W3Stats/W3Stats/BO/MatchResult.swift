//
//  MatchResult.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 18..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

struct MatchResult {
    
    enum ResultType {
        case win, lose
    }
    
    // TODO: let
    var vsRace: Race
    var resultType: ResultType
    
}
