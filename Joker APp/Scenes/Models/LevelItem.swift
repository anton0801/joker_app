//
//  LevelItem.swift
//  Joker APp
//
//  Created by Anton on 5/4/24.
//

import Foundation

struct LevelItem: Identifiable {
    let id: String = UUID().uuidString
    
    let level: Int
    let scoreTarget: Int
    let moves: Int
}

let levels = [
    LevelItem(level: 1, scoreTarget: 500, moves: 20),
    LevelItem(level: 2, scoreTarget: 600, moves: 15),
    LevelItem(level: 3, scoreTarget: 700, moves: 15),
    LevelItem(level: 4, scoreTarget: 800, moves: 15),
    LevelItem(level: 5, scoreTarget: 900, moves: 15),
    LevelItem(level: 6, scoreTarget: 1000, moves: 16),
    LevelItem(level: 7, scoreTarget: 1100, moves: 16),
    LevelItem(level: 8, scoreTarget: 1200, moves: 14),
    LevelItem(level: 9, scoreTarget: 1300, moves: 14),
    LevelItem(level: 10, scoreTarget: 1400, moves: 17),
    LevelItem(level: 11, scoreTarget: 1500, moves: 17),
    LevelItem(level: 12, scoreTarget: 1600, moves: 18),
    LevelItem(level: 13, scoreTarget: 1700, moves: 14),
    LevelItem(level: 14, scoreTarget: 1800, moves: 17),
    LevelItem(level: 15, scoreTarget: 1900, moves: 17),
    LevelItem(level: 16, scoreTarget: 2000, moves: 20),
    LevelItem(level: 17, scoreTarget: 2100, moves: 16),
    LevelItem(level: 18, scoreTarget: 2200, moves: 22),
    LevelItem(level: 19, scoreTarget: 2300, moves: 22),
    LevelItem(level: 20, scoreTarget: 2400, moves: 22),
    LevelItem(level: 21, scoreTarget: 2600, moves: 24),
    LevelItem(level: 22, scoreTarget: 2700, moves: 26),
    LevelItem(level: 23, scoreTarget: 2800, moves: 27),
    LevelItem(level: 24, scoreTarget: 2900, moves: 25),
    LevelItem(level: 25, scoreTarget: 3000, moves: 25)
]
