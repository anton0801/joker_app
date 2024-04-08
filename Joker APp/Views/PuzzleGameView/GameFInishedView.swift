//
//  GameFInishedView.swift
//  Joker APp
//
//  Created by Anton on 6/4/24.
//

import SwiftUI

struct GameFInishedView: View {
    
    @Environment(\.presentationMode) var presMode
    @EnvironmentObject var gameData: GameData
    
    var isArcadeGameMode: Bool
    
    var gannedScore: Int
    var gannedGoldCoins: Int {
        get {
            return gannedScore / 1000
        }
    }
    
    @State var isSoundsOn = UserDefaults.standard.bool(forKey: "isSoundsOn") {
        didSet {
            UserDefaults.standard.set(isSoundsOn, forKey: "isSoundsOn")
        }
    }
    
    var body: some View {
        VStack {
            Image("joker")
            
            if isArcadeGameMode {
                Text("ARCADE MODE")
                    .font(.custom(FontName.lilitOne, size: 52))
                    .foregroundColor(.white)
            } else {
                Text("CLASSIC MODE")
                    .font(.custom(FontName.lilitOne, size: 52))
                    .foregroundColor(.white)
            }
            
            HStack {
                Text("\(gannedScore)")
                    .font(.custom(FontName.lilitOne, size: 42))
                    .foregroundColor(.white)
                
                Image("score_label_image")
                
                Text("\(gannedScore)")
                    .font(.custom(FontName.lilitOne, size: 42))
                    .foregroundColor(.yellow)
            }
            
            HStack {
                Button {
                    presMode.wrappedValue.dismiss()
                } label: {
                    Image("ic_home")
                        .resizable()
                        .frame(width: 75, height: 75)
                }
                
                Button {
                    isSoundsOn = !isSoundsOn
                } label: {
                    if isSoundsOn {
                        Image("ic_sounds_on")
                            .resizable()
                            .frame(width: 75, height: 75)
                    } else {
                        Image("ic_sounds_off")
                            .resizable()
                            .frame(width: 75, height: 75)
                    }
                }
            }
            
            Spacer()
            
            HStack {
                VStack {
                    HStack {
                        Image("coin")
                        
                        Text("\(gameData.goldCoins - gannedGoldCoins)")
                            .foregroundColor(.white)
                            .font(.custom("LilitaOne", size: 18))
                            .padding(.trailing, 32)
                    }
                    .background(
                        Image("gold_coins_bg")
                    )
                }
                
                Text("+\(gannedGoldCoins)")
                    .foregroundColor(.white)
                    .font(.custom("LilitaOne", size: 52))
                
                Image("coin")
            }
            
            Spacer()
        }
        .onAppear {
            gameData.addGoldCoins(goldCoinsToAdd: gannedGoldCoins)
        }
        .background(
            Image("game_back")
                .resizable()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    GameFInishedView(isArcadeGameMode: false, gannedScore: 1000)
        .environmentObject(GameData())
}
