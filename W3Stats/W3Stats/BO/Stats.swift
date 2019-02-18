//
//  Stats.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 08..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

class Stats {
    let vsHuman: Desc
    let vsElf: Desc
    let vsOrc: Desc
    let vsUndead: Desc
    
    init(vsHuman: Desc, vsElf: Desc, vsOrc: Desc, vsUndead: Desc) {
        self.vsHuman = vsHuman
        self.vsElf = vsElf
        self.vsOrc = vsOrc
        self.vsUndead = vsUndead
    }
    
    convenience init?(vsHuman: Desc?, vsElf: Desc?, vsOrc: Desc?, vsUndead: Desc?) {
        guard let vsHuman = vsHuman, let vsElf = vsElf, let vsOrc = vsOrc, let vsUndead = vsUndead else {
            return nil
        }
        
        self.init(vsHuman: vsHuman, vsElf: vsElf, vsOrc: vsOrc, vsUndead: vsUndead)
    }
}
