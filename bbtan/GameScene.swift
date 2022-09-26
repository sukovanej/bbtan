//
//  GameScene.swift
//  bbtan
//
//  Created by Milan Suk on 25.09.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let ball = createBall()
    
    private static func createBall() -> SKSpriteNode {
        let ballRadius = 15 as CGFloat
        let ball = SKSpriteNode(imageNamed: "ball")
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        ball.physicsBody?.friction = 0.0
        ball.physicsBody?.restitution = 1.0
        ball.physicsBody?.allowsRotation = true
        ball.physicsBody?.linearDamping = 0.0
        ball.physicsBody?.angularDamping = 0.0
        ball.physicsBody?.allowsRotation = false
        
        return ball
    }
    
    private func createObstacle() -> SKSpriteNode {
        let obstacleEdgeSize = 50 as CGFloat
        let obstacleSize = CGSize(width: obstacleEdgeSize, height: obstacleEdgeSize)
        
        let obstacle = SKSpriteNode(color: .red, size: obstacleSize)
        obstacle.position = CGPoint(x: frame.midX + 10, y: frame.midY - 20)
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacleSize)
        obstacle.physicsBody?.isDynamic = false
        
        return obstacle
    }
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.restitution = 1.0
        physicsBody?.friction = 0.0
        
        ball.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(ball)
        addChild(createObstacle())
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        ball.physicsBody?.applyImpulse(CGVector(dx: 40, dy: 40))
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
