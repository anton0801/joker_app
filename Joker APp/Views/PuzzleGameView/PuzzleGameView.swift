//
//  PuzzleGameView.swift
//  Joker APp
//
//  Created by Anton on 5/4/24.
//

import SwiftUI
import SpriteKit

struct PuzzleGameView: View {
    
    @State var gameId: String? = nil
    @State var buyedBombId: String? = nil
    @State var gameScore: Int? = nil
    
    @EnvironmentObject var gameData: GameData
    
    var scene = PuzzleGameScene()
    
    var isArcadeGame: Bool
    var maxMoves: Int
    var targetScore: Int
    
    @State var gameOver: Bool = false
    
    var body: some View {
        if gameOver {
            GameFInishedView(isArcadeGameMode: isArcadeGame, gannedScore: gameScore!)
                .environmentObject(gameData)
        } else {
            VStack {
                SpriteView(scene: scene)
                    .ignoresSafeArea()
                    .onAppear {
                        if isArcadeGame {
                            scene.setIsArcadeGameMode()
                        }
                        scene.setTargets(maxMoves: maxMoves, targetScore: targetScore)
                    }
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("GAME_OVER"))) { notification in
                if let gameScore = notification.userInfo?["gameScore"] as? Int {
                    if let gameId = notification.userInfo?["gameId"] as? String {
                        if gameId != self.gameId {
                            gameOver = true
                            self.gameScore = gameScore
                            self.gameId = gameId
                        }
                    }
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("BUY_BOMB"))) { notification in
                if let bombId = notification.userInfo?["bombId"] as? String {
                    if bombId != buyedBombId {
                        self.buyedBombId = bombId
                        gameData.minusGoldCoins(goldCoinsToAdd: 5)
                    }
                }
            }
        }
    }
}

#Preview {
    PuzzleGameView(isArcadeGame: false, maxMoves: 20, targetScore: 1500)
        .environmentObject(GameData())
}
