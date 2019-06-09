//
//  GameScene.swift
//  Flying-Plane
//
//  Created by Abdul  Karim Khan on 07/06/2019.
//  Copyright © 2019 Abdul  Karim Khan. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var sky = SKSpriteNode()
    var aeroplane = SKSpriteNode()
    var crow1 = SKSpriteNode()
    var crow2 = SKSpriteNode()
    var coin1 = SKSpriteNode()
    var coin2 = SKSpriteNode()
    var gameover = SKLabelNode()
    var score = SKLabelNode()
    var coinscollected = Int()
    var reset = SKLabelNode()
    var livescore = SKLabelNode()
    
    override func didMove(to view: SKView) {
        // Get label node from scene and store it for use later
        aeroplane = self.childNode(withName: "aeroplane") as! SKSpriteNode
        crow1 = self.childNode(withName: "crow1") as! SKSpriteNode
        crow2 = self.childNode(withName: "crow2") as! SKSpriteNode
        coin1 = self.childNode(withName: "coin1") as! SKSpriteNode
        coin2 = self.childNode(withName: "coin2") as! SKSpriteNode
        gameover = self.childNode(withName: "gameover") as! SKLabelNode
        score = self.childNode(withName: "score") as! SKLabelNode
        reset = self.childNode(withName: "reset") as! SKLabelNode
        sky = self.childNode(withName: "bgsky") as! SKSpriteNode
        livescore = self.childNode(withName: "livescore") as! SKLabelNode
        
        startGame()
        
        
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 0
        self.physicsBody = border
        
        

    }
    
    func startGame(){
        coinscollected = 0
        livescore.text = "\(coinscollected)"
        gameover.isHidden = true
        reset.isHidden = true
        score.isHidden = true
        
//        sky.physicsBody?.applyImpulse(CGVector(dx: -5, dy: 0))
//        sky.physicsBody?.velocity = CGVector(dx: -140.0, dy: 0)
//
        crow1.position = CGPoint(x: 720.504, y: 109.496)
        crow1.physicsBody?.applyImpulse(CGVector(dx: -5, dy: 0))
        crow1.physicsBody?.velocity = CGVector(dx: -240.0, dy: 0)
        
        crow2.position = CGPoint(x: 720.504, y: -158.259)
        crow2.physicsBody?.applyImpulse(CGVector(dx: -5, dy: 0))
        crow2.physicsBody?.velocity = CGVector(dx: -140.0, dy: 0)
        
        coin1.position = CGPoint(x: 711.122, y: 2.0)
        coin1.physicsBody?.applyImpulse(CGVector(dx: -5, dy: 0))
        coin1.physicsBody?.velocity = CGVector(dx: -100.0, dy: 0)
        
        coin2.physicsBody?.applyImpulse(CGVector(dx: -5, dy: 0))
        coin2.physicsBody?.velocity = CGVector(dx: -180.0, dy: 0)
        coin2.position = CGPoint(x: 706.8, y: -203)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            aeroplane.run(SKAction.moveTo(x: location.x, duration: 0.2))
            aeroplane.run(SKAction.moveTo(y: location.y, duration: 0.2))
        }
        let touch = touches.first
        let positionInScene = touch!.location(in: self)
        let touchedNode = self.atPoint(positionInScene)
        
        if let name = touchedNode.name {
            if name == "reset" {
                startGame()
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            let location = touch.location(in: self)
            aeroplane.run(SKAction.moveTo(x: location.x, duration: 0.2))
            aeroplane.run(SKAction.moveTo(y: location.y, duration: 0.2))
        }
    }
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered'
        let crow1cross = crow1.position.x < self.frame.minX
        let crow2cross = crow2.position.x < self.frame.minX
        let coin1cross = coin1.position.x < self.frame.minX
        let coin2cross = coin2.position.x < self.frame.minX
//        let skycross = (sky.position.x + (sky.size.width/2)) < self.frame.minX
        let aeroplanecoin1 = aeroplane.intersects(coin1)
        let aeroplanecoin2 = aeroplane.intersects(coin2)
        let aeroplanecrow1 = aeroplane.intersects(crow1)
        let aeroplanecrow2 = aeroplane.intersects(crow2)
        
//        if skycross {
//            sky.physicsBody?.applyImpulse(CGVector(dx: -5, dy: 0))
//            sky.physicsBody?.velocity = CGVector(dx: -140.0, dy: 0)
//        }
//        //check if node has crossed border
        if crow1cross {
            crow1.position = CGPoint(x: 720.504, y: 109.496)
        }
        if crow2cross {
            crow2.position = CGPoint(x: 720.504, y: -158.259)
        }
        if coin1cross || aeroplanecoin1 {
            coin1.position = CGPoint(x: 711.122, y: 2.0)
        }
        if coin2cross || aeroplanecoin2 {
            coin2.position = CGPoint(x: 706.8, y: -203)
        }
        
        if aeroplanecoin1 || aeroplanecoin2{
            coinscollected += 1
            livescore.text = "\(coinscollected)"
        }
        if aeroplanecrow1 || aeroplanecrow2 {
            gameOver()
        }
    }
    
    func gameOver(){
        crow1.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        crow2.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        coin1.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        coin2.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        crow1.position = CGPoint(x: self.frame.maxX + crow1.size.width + 100, y: 0)
        crow2.position = CGPoint(x: self.frame.maxX + crow2.size.width + 100, y: 0)
        coin1.position = CGPoint(x: self.frame.maxX + coin1.size.width + 100, y: 0)
        coin2.position = CGPoint(x: self.frame.maxX + coin2.size.width + 100, y: 0)
        
        score.isHidden = false
        gameover.isHidden = false
        reset.isHidden = false
        score.text = "\(coinscollected)"
    }
}

