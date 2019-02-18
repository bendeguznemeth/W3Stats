//
//  Race.swift
//  W3Stats
//
//  Created by Németh Bendegúz on 2019. 02. 07..
//  Copyright © 2019. Németh Bendegúz. All rights reserved.
//

enum Race: String {
    
    static let allRaces: [Race] = [.elf, .human, .orc, .undead]
    
    static let count = 4
    
    case human
    case elf
    case orc
    case undead
    
    init(rawValue: String) {
        switch rawValue {
        case "elf":
            self = .elf
        case "orc":
            self = .orc
        case "undead":
            self = .undead
        default:
            self = .human
        }
    }
    
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
