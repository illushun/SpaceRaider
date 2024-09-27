import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var engine: Voyager!
    
    // UI
    var scoreLabel: SKLabelNode!
    var pointsLabel: SKLabelNode!
    var testLabel: SKLabelNode!
    
    var fireButton: SKLabelNode!
    
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        
        self.engine = Voyager(scene: self)
        self.engine.testLog()
        
        self.scoreLabel = SpaceUI.label(text: "Score: \(self.engine.getScore())", position: CGPoint(x: 80, y: self.size.height - 80), color: .white)
        self.pointsLabel = SpaceUI.label(text: "Points: \(self.engine.getPoints())", position: CGPoint(x: 80, y: self.size.height - 110), color: .white)
        self.testLabel = SpaceUI.label(text: "VoyagerEngine Dev Environment", position: CGPoint(x: self.size.width / 2, y: 50), color: .white)
        
        // Set up fire button
        self.fireButton = SpaceUI.button(text: "FIRE", position: CGPoint(x: self.size.width - 80, y: 120), color: .blue, nodeName: "fireButton")
        
        addChild(self.scoreLabel)
        addChild(self.pointsLabel)
        addChild(self.testLabel)
        addChild(self.fireButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let node = self.atPoint(location)
        
        self.engine.touchesBegan(location: location, node: node)
    }

    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        self.engine.update()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody

        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        self.engine.didBegin(firstBody: firstBody, secondBody: secondBody)
    }
}
