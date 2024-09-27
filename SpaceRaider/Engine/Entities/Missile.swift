import SpriteKit

class Missile: Entity {
    init(position: CGPoint, gameScene: SKScene?) {
        guard let scene = gameScene else {
            fatalError("Cannot initialise Player without a gameScene")
        }
        super.init(image: "spaceship", bitmask: projectileCategory, gameScene: scene)
        
        self.position = position
        
        gameScene?.addChild(self)
        
        self.physicsBody?.contactTestBitMask = enemyCategory
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
