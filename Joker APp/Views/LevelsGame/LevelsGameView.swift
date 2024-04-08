//
//  LevelsGameView.swift
//  Joker APp
//
//  Created by Anton on 2/4/24.
//

import SwiftUI

struct LevelsGameView: View {
    
    @EnvironmentObject var gameData: GameData
    
    @Environment(\.presentationMode) var presMode
    
    var isArcadeMode: Bool
    
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
                    Text("LEVELS")
                        .font(.custom(FontName.lilitOne, size: 52))
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 1, x: 0, y: 2)
                        .shadow(color: .white, radius: 4, x: 0, y: 4)
                }
                
                Spacer()
            }
            .padding()
            
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.flexible(minimum: 140), spacing: 1),
                    GridItem(.flexible(minimum: 140), spacing: 1),
                    GridItem(.flexible(minimum: 140), spacing: 1)
                ]) {
                    ForEach(levels, id: \.id) { level in
                        NavigationLink(destination: PuzzleGameView(isArcadeGame: isArcadeMode, maxMoves: level.moves, targetScore: level.scoreTarget)
                            .environmentObject(gameData)) {
                            ZStack {
                                Image("level_bg")
                                Text("\(level.level)")
                                    .font(.custom(FontName.lilitOne, size: 52))
                                    .foregroundColor(.white)
                            }
                        }
                    }
                }
            }
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
    LevelsGameView(isArcadeMode: false)
        .environmentObject(GameData())
}
