//
//  Species.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 07..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

enum Species: String {
    
    static let allSpecies: [Species] = [.elf, .human, .orc, .undead]
    
    static let count = 4
    
    case human
    case elf
    case orc
    case undead
    
    func displayableValue() -> String {
        switch self {
        case .human:
            return "Human"
        case .elf:
            return "Elf"
        case .orc:
            return "Orc"
        case .undead:
            return "Undead"
        }
    }
}
