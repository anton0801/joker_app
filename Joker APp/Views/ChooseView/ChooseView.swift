//
//  ChooseView.swift
//  Joker APp
//
//  Created by Anton on 2/4/24.
//

import SwiftUI

struct ChooseView: View {
    
    @State var gameData: GameData = GameData()
    
    @State var isSoundsOn = UserDefaults.standard.bool(forKey: "isSoundsOn") {
        didSet {
            UserDefaults.standard.set(isSoundsOn, forKey: "isSoundsOn")
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        isSoundsOn = !isSoundsOn
                    } label: {
                        if isSoundsOn {
                            Image("ic_sounds_on")
                        } else {
                            Image("ic_sounds_off")
                        }
                    }
                    
                    NavigationLink(destination: RewardsView()
                        .environmentObject(gameData)
                        .navigationBarBackButtonHidden()) {
                        Image("ic_rewards")
                    }
                    
                    NavigationLink(destination: InfoView()
                        .navigationBarBackButtonHidden()) {
                            Image("ic_info")
                        }
                }
                
                Spacer()
                
                VStack {
                    HStack {
                        Image("coin")
                        
                        Text("\(gameData.goldCoins)")
                            .foregroundColor(.white)
                            .font(.custom("LilitaOne", size: 18))
                            .padding(.trailing, 32)
                    }
                    .background(
                        Image("gold_coins_bg")
                    )
                }
                
                Spacer().frame(height: 32)
                
                NavigationLink(destination: LevelsGameView(isArcadeMode: false)
                    .environmentObject(gameData)
                    .navigationBarBackButtonHidden()) {
                    Image("classic_game")
                }                
                
                Spacer().frame(height: 24)
                
                NavigationLink(destination: LevelsGameView(isArcadeMode: true)
                    .environmentObject(gameData)
                    .navigationBarBackButtonHidden()) {
                    Image("arcade_game")
                }
                
                Spacer()
            }
            .background(
                Image("game_app_back")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .ignoresSafeArea()
            )
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    ChooseView()
}
