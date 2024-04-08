//
//  GameData.swift
//  Joker APp
//
//  Created by Anton on 6/4/24.
//

import Foundation

class GameData: ObservableObject {
    
    @Published var goldCoins = UserDefaults.standard.integer(forKey: "gold_coins") {
        didSet {
            UserDefaults.standard.set(goldCoins, forKey: "gold_coins")
        }
    }
    var allRewards = [
        "day_1", "day_2", "day_3", "day_4", "day_5", "day_6", "day_7"
    ]
    @Published var dailyRewardsAvailable: [String] = []
    @Published var dailyRewardsClaimed: [String] = []
    
    init() {
        let dailyRewardsClaimedComponentsSaved = UserDefaults.standard.string(forKey: "dailyRewardsClaimed")?.components(separatedBy: ",") ?? []
        for reward in dailyRewardsClaimedComponentsSaved {
            dailyRewardsClaimed.append(reward)
        }
        
        var rewardsDiff = [String]()
        for reward in allRewards {
            if !dailyRewardsClaimed.contains(reward) {
                rewardsDiff.append(reward)
            }
        }
        dailyRewardsAvailable = rewardsDiff
    }
    
    func canClaimReward() -> Bool {
        let savedDate = UserDefaults.standard.object(forKey: "lastClaimedDate") as? Date
        guard let claimedDate = savedDate else {
            return true
        }
        return Date().timeIntervalSince(claimedDate) >= 24 * 60 * 60
    }
    
    func claimReward(reward: RewardModel) -> Bool {
        if dailyRewardsAvailable[0] == reward.id {
            if canClaimReward() {
                dailyRewardsClaimed.append(reward.id)
                UserDefaults.standard.set(dailyRewardsClaimed.joined(separator: ","), forKey: "dailyRewardsClaimed")
                addGoldCoins(goldCoinsToAdd: reward.reward)
                return true
            }
            return false
        }
        return false
    }
    
    func addGoldCoins(goldCoinsToAdd: Int) {
        goldCoins += goldCoinsToAdd
    }
    
    func minusGoldCoins(goldCoinsToAdd: Int) {
        goldCoins -= goldCoinsToAdd
    }
    
}
