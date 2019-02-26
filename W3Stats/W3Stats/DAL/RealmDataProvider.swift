//
//  RealmDataProvider.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 18..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

import RealmSwift

protocol DataProviding {
    func savePlayer(player: Player, onFailed: () -> Void)
    func updatePlayer(player: Player, onFailed: () -> Void)
    func loadPlayers() -> [Player]
    func loadPlayer(name: String) -> Player?
    func deletePlayer(name: String, onFailed: () -> Void)
}

class RealmDataProvider: DataProviding {
    
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    // MARK: - Save
    
    func savePlayer(player: Player, onFailed: () -> Void) {
        let playerObject = RealmDataParser.playerObjectFromPlayer(player)
        
        do {
            try self.realm.write {
                self.realm.add(playerObject)
            }
        } catch {
            onFailed()
        }
    }
    
    // MARK: - Update
    
    func updatePlayer(player: Player, onFailed: () -> Void) {
        let playerObject = RealmDataParser.playerObjectFromPlayer(player)
        
        do {
            try self.realm.write {
                self.realm.add(playerObject, update: true)
            }
        } catch {
            onFailed()
        }
    }
    
    // MARK: - Load
    
    func loadPlayers() -> [Player] {
        let playerObjects = Array(self.realm.objects(PlayerObject.self))
        let players = playerObjects.compactMap({ RealmDataParser.playerFromPlayerObject($0) })
        
        return players
    }
    
    func loadPlayer(name: String) -> Player? {
        let playerObject = self.realm.object(ofType: PlayerObject.self, forPrimaryKey: name)
        let player = RealmDataParser.playerFromPlayerObject(playerObject)
        
        return player
    }
    
    // MARK: - Delete
    
    func deletePlayer(name: String, onFailed: () -> Void) {
        guard let playerObject = self.realm.object(ofType: PlayerObject.self, forPrimaryKey: name) else {
            onFailed()
            return
        }
        
        do {
            try self.realm.write {
                self.realm.delete(playerObject)
            }
        } catch {
            onFailed()
        }
    }
    
}
