//
//  GameScene.swift
//  bbtan
//
//  Created by Milan Suk on 25.09.2022.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var obstaclePoints = 50
    
    private func createBall() -> SKSpriteNode {
        let ballRadius = 15 as CGFloat
        
        let ball = SKSpriteNode(imageNamed: "ball")
        ball.name = "ball"
        ball.position = CGPoint(x: frame.midX, y: frame.midY)
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        ball.physicsBody?.friction = 0.0
        ball.physicsBody?.restitution = 1.0
        ball.physicsBody?.allowsRotation = true
        ball.physicsBody?.linearDamping = 0.0
        ball.physicsBody?.angularDamping = 0.0
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
        
        return ball
    }
    
    private func createObstacle() -> SKSpriteNode {
        let obstacleEdgeSize = 50 as CGFloat
        let obstacleSize = CGSize(width: obstacleEdgeSize, height: obstacleEdgeSize)
        
        let obstacle = SKSpriteNode(color: .red, size: obstacleSize)
        obstacle.name = "obstacle"
        obstacle.position = CGPoint(x: frame.midX + 10, y: frame.midY - 10)
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacleSize)
        obstacle.physicsBody?.isDynamic = false
        
        return obstacle
    }
    
    private func createObstaclePoints() -> SKLabelNode {
        let obstaclePoints = SKLabelNode(text: String(obstaclePoints))
        obstaclePoints.name = "obstaclePoints"
        obstaclePoints.fontSize = 23
        obstaclePoints.fontName = "AvenirNext-Bold"
        obstaclePoints.position = CGPoint(x: frame.midX + 9, y: frame.midY - 18)
        return obstaclePoints
    }
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsBody?.restitution = 1.0
        physicsBody?.friction = 0.0
        
        physicsWorld.contactDelegate = self
        
        addChild(createBall())
        addChild(createObstacle())
        addChild(createObstaclePoints())
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let ball = childNode(withName: "ball") {
            ball.physicsBody?.applyImpulse(CGVector(dx: 40, dy: 40))
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "obstacle" || nodeB.name == "obstacle" {
            obstaclePoints -= 1
            (childNode(withName: "obstaclePoints") as? SKLabelNode)?.text = String(obstaclePoints - 1)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
