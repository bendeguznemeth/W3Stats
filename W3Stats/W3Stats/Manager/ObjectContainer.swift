//
//  ObjectContainer.swift
//  W3Stats
//
//  Created by Papp Balázs on 2019. 02. 19..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import RealmSwift

class ObjectContainer: NSObject {

    static let sharedInstance = ObjectContainer()
    
    let dataProvider: RealmDataProvider
    
    private override init() {
        let realm = try! Realm.init()
        self.dataProvider = RealmDataProvider.init(realm: realm)
    }
    
}
