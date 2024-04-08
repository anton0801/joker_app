//
//  RewardModel.swift
//  Joker APp
//
//  Created by Anton on 2/4/24.
//

import Foundation

struct RewardModel: Identifiable {
    let id: String
    let name: String
    let reward: Int
}

let rewards = [
    RewardModel(id: "day_1", name: "DAY 1", reward: 5),
    RewardModel(id: "day_2", name: "DAY 2", reward: 15),
    RewardModel(id: "day_3", name: "DAY 3", reward: 25),
    RewardModel(id: "day_4", name: "DAY 4", reward: 35),
    RewardModel(id: "day_5", name: "DAY 5", reward: 55),
    RewardModel(id: "day_6", name: "DAY 6", reward: 75),
    RewardModel(id: "day_7", name: "DAY\n7", reward: 100)
]
