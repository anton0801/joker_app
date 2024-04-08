//
//  RewardsView.swift
//  Joker APp
//
//  Created by Anton on 2/4/24.
//

import SwiftUI

struct RewardsView: View {
    
    @EnvironmentObject var gameData: GameData
    
    @Environment(\.presentationMode) var presMode
    
    var rewardsColumns = [
        GridItem(.flexible(minimum: 120), spacing: 0),
        GridItem(.flexible(minimum: 120), spacing: 0),
        GridItem(.flexible(minimum: 120), spacing: 0)
    ]
    
    @State var showAlertClaimReward = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    presMode.wrappedValue.dismiss()
                } label: {
                    Image("ic_home")
                }
                
                VStack {
                    Spacer().frame(height: 42)
                    Text("DAILY")
                        .font(.custom(FontName.lilitOne, size: 52))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 1, x: 0, y: 2)
                        .shadow(color: .white, radius: 4, x: 0, y: 4)
                }
                
                Spacer()
            }
            .padding()
            
            Spacer().frame(height: 24)
            
            VStack {
                LazyVGrid(columns: rewardsColumns, spacing: 2) {
                    ForEach(rewards, id: \.id) { rewardItem in
                        if rewardItem.name != "DAY\n7" {
                            if self.gameData.dailyRewardsClaimed.contains(rewardItem.id) {
                                VStack {
                                    Text(rewardItem.name)
                                        .font(.custom(FontName.lilitOne, size: 30))
                                        .foregroundColor(.white)
                                    
                                    HStack {
                                        Text("\(rewardItem.reward)")
                                            .font(.custom(FontName.lilitOne, size: 30))
                                            .foregroundColor(.white)
                                        
                                        Image("coin")
                                            .frame(width: 40, height: 40)
                                            .padding(.bottom, 8)
                                    }
                                    .padding(.top, 50)
                                }
                                .padding()
                                .background(
                                    Image("shadow_tab_completed")
                                )
                            } else if self.gameData.dailyRewardsAvailable[0] == rewardItem.id {
                                Button {
                                    showAlertClaimReward = gameData.claimReward(reward: rewardItem)
                                } label: {
                                    VStack {
                                        Text(rewardItem.name)
                                            .font(.custom(FontName.lilitOne, size: 30))
                                            .foregroundColor(.white)
                                        
                                        HStack {
                                            Text("\(rewardItem.reward)")
                                                .font(.custom(FontName.lilitOne, size: 30))
                                                .foregroundColor(.white)
                                            
                                            Image("coin")
                                                .frame(width: 40, height: 40)
                                                .padding(.bottom, 8)
                                        }
                                        .padding(.top, 50)
                                    }
                                    .padding()
                                    .background(
                                        Image("shadow_tab_current")
                                    )
                                }
                            } else {
                                VStack {
                                    Text(rewardItem.name)
                                        .font(.custom(FontName.lilitOne, size: 30))
                                        .foregroundColor(.white)
                                    
                                    HStack {
                                        Text("\(rewardItem.reward)")
                                            .font(.custom(FontName.lilitOne, size: 30))
                                            .foregroundColor(.white)
                                        
                                        Image("coin")
                                            .frame(width: 40, height: 40)
                                            .padding(.bottom, 8)
                                    }
                                    .padding(.top, 50)
                                }
                                .padding()
                                .background(
                                    Image("shadow_tab")
                                )
                            }
                            
                            
                        }
                    }
                }
                
                HStack {
                    let rewardItem = rewards[rewards.count - 1]
                    Text(rewardItem.name)
                        .font(.custom(FontName.lilitOne, size: 30))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Spacer().frame(width: 4)
                    
                    Text("\(rewardItem.reward)")
                        .font(.custom(FontName.lilitOne, size: 30))
                        .foregroundColor(.white)
                    
                    Image("coin")
                        .frame(width: 40, height: 40)
                }
                .padding()
                .background(
                    Image("shadow_tab_gorizontal")
                )
            }
            .frame(width: 250)
            
            Spacer()
        }
        .background(
            Image("game_app_back")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    RewardsView()
        .environmentObject(GameData())
}
