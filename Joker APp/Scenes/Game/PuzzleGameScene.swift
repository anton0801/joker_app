//
//  PuzzleGameScene.swift
//  Joker APp
//
//  Created by Anton on 5/4/24.
//

import Foundation
import SpriteKit
import GameKit

class PuzzleGameScene: SKScene {
    
    // todo: сделать покупку бомбы, + доделать UI, за каждые 1000 очков доеться 1 зотоая монетка
    
    var gameId: String = UUID().uuidString
    
    var isArcadeGame: Bool = false
    
    var cols = [[Item]]()
    var itemSize: CGFloat = 60
    var itemsPerColum = 10
    var itemsPerRow = 10
    let itemImages = ["image_1","image_2","image_3"]
    var currentMatch = Set<Item>()
    var targetScore: Int = 1000
    var buyBombBtn: SKSpriteNode!
    
    var maxMovesAvailable = 20 {
        didSet {
            movesLabel.text = "Moves: \(currentMoves)/\(maxMovesAvailable)"
        }
    }
    var currentMoves = 0 {
        didSet {
            movesLabel.text = "Moves: \(currentMoves)/\(maxMovesAvailable)"
        }
    }
    var gameScore = 0 {
        didSet {
            scoreLabel.text = "\(gameScore)"
        }
    }
    
    var buyBomb = false
    
    var scoreLabel: SKLabelNode = SKLabelNode()
    var movesLabel: SKLabelNode = SKLabelNode()
    var goldCoinsLabel: SKLabelNode = SKLabelNode()
    
    var goldCoins = UserDefaults.standard.integer(forKey: "gold_coins")
    
    func setTargets(maxMoves: Int, targetScore: Int) {
        self.targetScore = targetScore
        self.maxMovesAvailable = maxMoves
    }
    
    override func didMove(to view: SKView) {
        scene?.size = CGSize(width: 750, height: 1100)
        
        let back = SKSpriteNode(imageNamed: "game_back")
        back.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(back)
        
        createItems()
        createScoreLabel()
        createMovesLabel()
        
        setUpUIComponents()
        createMonetizeUI()
    }
    
    private func createMonetizeUI() {
        let goldCoinsBg = SKSpriteNode(imageNamed: "gold_coins_bg")
        goldCoinsBg.size = CGSize(width: 120, height: 40)
        goldCoinsBg.position = CGPoint(x: size.width - goldCoinsBg.size.width, y: 40)
        addChild(goldCoinsBg)
        
        let coin = SKSpriteNode(imageNamed: "coin")
        coin.position = CGPoint(x: goldCoinsBg.position.x - (goldCoinsBg.size.width / 2), y: goldCoinsBg.position.y)
        coin.size = CGSize(width: 60, height: 60)
        addChild(coin)
        
        goldCoinsLabel = SKLabelNode(text: "\(goldCoins)")
        goldCoinsLabel.fontName = FontName.lilitOne
        goldCoinsLabel.fontSize = 28
        goldCoinsLabel.position = CGPoint(x: goldCoinsBg.position.x, y: goldCoinsBg.position.y - 12)
        addChild(goldCoinsLabel)
        
        if isArcadeGame {
            addBuyBombBtn()
        }
    }
    
    private func addBuyBombBtn() {
        let bombPrice = SKLabelNode(text: "5")
        bombPrice.fontName = FontName.lilitOne
        bombPrice.fontSize = 28
        bombPrice.position = CGPoint(x: 50, y: 40)
        addChild(bombPrice)
        
        let coinImage = SKSpriteNode(imageNamed: "coin")
        coinImage.position = CGPoint(x: 110, y: 50)
        coinImage.size = CGSize(width: 70, height: 60)
        addChild(coinImage)
        
        buyBombBtn = SKSpriteNode(imageNamed: "buy_bomb_btn")
        buyBombBtn.position = CGPoint(x: coinImage.position.x + coinImage.frame.width + 10, y: 50)
        buyBombBtn.size = CGSize(width: 90, height: 60)
        buyBombBtn.name = "buy_bomb"
        addChild(buyBombBtn)
    }
    
    private func createMovesLabel() {
        movesLabel = SKLabelNode(text: "Moves: 0/\(maxMovesAvailable)")
        movesLabel.fontName = FontName.lilitOne
        movesLabel.fontSize = 28
        movesLabel.position.x = scoreLabel.position.x + 60
        movesLabel.position.y = scoreLabel.position.y - 40
        addChild(movesLabel)
        
        let targetScore = SKLabelNode(text: "Target score: \(targetScore)")
        targetScore.fontName = FontName.lilitOne
        targetScore.fontSize = 28
        targetScore.position.x = movesLabel.position.x
        targetScore.position.y = movesLabel.position.y - 40
        addChild(targetScore)
    }
    
    func makeScore() {
        let newScore = currentMatch.count
        
        if newScore == 1 {
            // Game Over
        } else if newScore == 2 {
            let matchCount = min(newScore, 2)
            let scoreToAdd = pow(2, Double(matchCount))
            gameScore += Int(scoreToAdd)
        } else {
            let matchCount = min(newScore, 6)
            let scoreToAdd = pow(2, Double(matchCount))
            gameScore += Int(scoreToAdd)
        }
    }
    
    private func createScoreLabel() {
        scoreLabel = SKLabelNode()
        scoreLabel.text = "0"
        scoreLabel.fontName = FontName.lilitOne
        scoreLabel.fontSize = 52
        scoreLabel.position = CGPoint(x: size.width / 2 - 50, y: size.height - 200)
        
        addChild(scoreLabel)
        
        let scoreIcon = SKSpriteNode(imageNamed: "score_label_image")
        scoreIcon.position.x = scoreLabel.position.x + scoreLabel.frame.width + 80
        scoreIcon.position.y = scoreLabel.position.y + (scoreLabel.frame.height / 2)
        scoreIcon.size = CGSize(width: 100, height: 70)
        addChild(scoreIcon)
    }
    
    private func setUpUIComponents() {
        let joker1 = SKSpriteNode(imageNamed: "joker")
        joker1.size = CGSize(width: 150, height: 130)
        joker1.position = CGPoint(x: joker1.size.width, y: size.height - joker1.size.height)
        addChild(joker1)
        
        let joker2 = SKSpriteNode(imageNamed: "joker")
        joker2.size = CGSize(width: 150, height: 130)
        joker2.position = CGPoint(x: size.width - joker2.size.width, y: size.height - joker2.size.height)
        addChild(joker2)
    }
    
    func setIsArcadeGameMode() {
        isArcadeGame = true
    }
    
    private func createItems() {
        for x in 0..<itemsPerRow {
            var col = [Item]()
            for y in 0..<itemsPerColum {
                let item = createItem(row: y, col: x)
                col.append(item)
            }
            
            cols.append(col)
        }
    }
    
    func positionItem(for item: Item) -> CGPoint {
        let xOffset: CGFloat = 100
        let yOffset: CGFloat = 200
        let x = xOffset + itemSize * CGFloat(item.col)
        let y = yOffset + itemSize * CGFloat(item.row)
        return CGPoint(x: x, y: y)
    }
    
    func createItem(row: Int, col: Int, startOff screen: Bool = false) -> Item {
        var itemImage = ""
        if buyBomb {
            itemImage = "bomb"
            buyBomb = false
        } else {
            itemImage = itemImages[GKRandomSource.sharedRandom().nextInt(upperBound: itemImages.count)]
        }
        let item = Item(imageNamed: itemImage)
        item.name = itemImage
        item.row = row
        item.col = col
        
        if screen {
            let finalPosition = positionItem(for: item)
            item.position = finalPosition
            item.position.y += 600
            
            let downAction = SKAction.move(to: finalPosition, duration: 0.4)
            item.run(downAction)
            isUserInteractionEnabled = true
        } else {
            item.position = positionItem(for: item)
        }
        
        item.size = CGSize(width: itemSize, height: itemSize)
        addChild(item)
        return item
    }
    
    func findItem(in point: CGPoint) -> Item? {
        let item = nodes(at: point).compactMap { $0 as? Item }
        
        return item.first
    }
    
    func findMatch(for original: Item) {
        var checkItems = [Item?]()
        currentMatch.insert(original)
        let position = original.position
        
        checkItems.append(findItem(in: CGPoint(x: position.x, y: position.y - itemSize)))
        checkItems.append(findItem(in: CGPoint(x: position.x, y: position.y + itemSize)))
        checkItems.append(findItem(in: CGPoint(x: position.x - itemSize, y: position.y)))
        checkItems.append(findItem(in: CGPoint(x: position.x + itemSize, y: position.y)))
        
        for case let check? in checkItems {
            if currentMatch.contains(check) {
                continue
            }
            if check.name == original.name || original.name == "bomb" {
                findMatch(for: check)
            }
        }
    }
    
    func removeMatches() {
        let sortedMatches = currentMatch.sorted {
            $0.row > $1.row
        }
        
        for item in sortedMatches {
            cols[item.col].remove(at: item.row)
            item.removeFromParent()
        }
//        currentMatch = []
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let location = touch.location(in: self)
        
        if isArcadeGame {
            guard !nodes(at: location).contains(buyBombBtn) else {
                let currentGoldCoins = UserDefaults.standard.integer(forKey: "gold_coins")
                if currentGoldCoins >= 5 {
                    buyBomb = true
                    let item = createItem(row: GKRandomSource.sharedRandom().nextInt(upperBound: 10), col: GKRandomSource.sharedRandom().nextInt(upperBound: 10), startOff: false)
                    goldCoins -= 5
                    goldCoinsLabel.text = "\(goldCoins)"
                    UserDefaults.standard.set(goldCoins, forKey: "gold_coins")
                    NotificationCenter.default.post(name: Notification.Name("BUY_BOMB"), object: nil, userInfo: ["bombId": UUID().uuidString])
                }
                return
            }
        }
        
        guard let tappedItem = findItem(in: location) else {
            return
        }
        
        if currentMoves < maxMovesAvailable {
            currentMoves += 1
            
            isUserInteractionEnabled = false
            
            currentMatch.removeAll()
            if tappedItem.name == "bomb" {
                bombExplosion(for: tappedItem)
            }
            findMatch(for: tappedItem)
            removeMatches()
            moveDown()
            makeScore()
            
            if gameScore >= targetScore {
                let diffMoves = maxMovesAvailable - currentMoves
                gameScore += diffMoves * 200
                NotificationCenter.default.post(name: Notification.Name("GAME_OVER"), object: nil, userInfo: ["gameId": gameId, "gameScore": gameScore])
            }
            
            if currentMoves == maxMovesAvailable {
                NotificationCenter.default.post(name: Notification.Name("GAME_OVER"), object: nil, userInfo: ["gameId": gameId, "gameScore": gameScore])
            }
        }
    }
    
    func moveDown() {
        for (columnIndex, col) in cols.enumerated() {
            for (rowIndex, item) in col.enumerated() {
                item.row = rowIndex
                let downAction = SKAction.move(to: positionItem(for: item), duration: 0.3)
                item.run(downAction)
            }
            while cols[columnIndex].count < itemsPerRow {
                let item = createItem(row: cols[columnIndex].count, col: columnIndex, startOff: true)
                cols[columnIndex].append(item)
            }
        }
    }
    
    func bombExplosion(for item: Item) {
        let explosion = SKEmitterNode(fileNamed: "Explosion")
        explosion?.position = item.position
        explosion?.zPosition = 10
        self.run(SKAction.wait(forDuration: 2)) {
            explosion?.removeFromParent()
        }
    }
    
}
