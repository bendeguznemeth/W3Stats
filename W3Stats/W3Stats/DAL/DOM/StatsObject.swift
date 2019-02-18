//
//  StatsObject.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 08..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import RealmSwift

class StatsObject: Object {
    @objc dynamic var vsHuman: DescObject? = nil
    @objc dynamic var vsElf: DescObject? = nil
    @objc dynamic var vsOrc: DescObject? = nil
    @objc dynamic var vsUndead: DescObject? = nil
}
