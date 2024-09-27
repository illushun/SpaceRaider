import SpriteKit

let playerCategory: UInt32 = 0x1 << 0
let enemyCategory: UInt32 = 0x1 << 2
let projectileCategory: UInt32 = 0x1 << 1

class Entity: SKSpriteNode {
    weak var gameScene: SKScene?
    
    var health: CGFloat = 100.0
    var maxHealth: CGFloat = 100.0
    var damage: CGFloat = 10.0
    
    var canShoot: Bool = true
    var cooldownTime: TimeInterval = 1.0
    
    init(image: String, bitmask: UInt32, gameScene: SKScene?) {
        let texture = SKTexture(imageNamed: image)
        super.init(texture: texture, color: .clear, size: CGSize(width: 50, height: 50))
        self.gameScene = gameScene
        
        //self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        //self.physicsBody?.isDynamic = true
        //self.physicsBody?.collisionBitMask = 0
        
        self.physicsBody = SKPhysicsBody(rectangleOf: self.size)
        self.physicsBody?.isDynamic = true
        self.physicsBody?.categoryBitMask = bitmask
        self.physicsBody?.collisionBitMask = 0
        self.physicsBody?.affectedByGravity = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /* Getters */
    
    func getGameScene() -> SKScene? {
        return self.gameScene
    }
    
    func getHealth() -> CGFloat {
        return self.health
    }
    
    func getMaxHealth() -> CGFloat {
        return self.maxHealth
    }
    
    func getCanShoot() -> Bool {
        return self.canShoot
    }
    
    /* Setters */
    
    func setGameScene(gameScene: SKScene) {
        self.gameScene = gameScene
    }
    
    func setHealth(health: CGFloat = 100.0) {
        self.health = health
    }
    
    func setMaxHealth(maxHealth: CGFloat = 100.0) {
        self.maxHealth = maxHealth
    }
    
    func move(to position: CGPoint) {
        let moveAction = SKAction.move(to: position, duration: 2.0)
        moveAction.timingFunction = { time in
            return time * time * (3 - 2 * time)
        }
        self.run(moveAction)
    }
    
    func moveSequence(sequence: SKAction) {
        self.run(sequence)
    }
    
    // override this per entity
    func shoot() {
        canShoot = false
        self.cooldown()
    }
    
    // override this per entity
    func cooldown() {
        let waitAction = SKAction.wait(forDuration: cooldownTime)
        let enableShooting = SKAction.run { [weak self] in
            self?.canShoot = true
        }
        gameScene?.run(SKAction.sequence([waitAction, enableShooting]))
    }
    
    func takeDamage(_ damage: CGFloat) {
        health -= damage
        if health <= 0.0 {
            self.removeFromParent()
            health = 0.0
        }
    }
}
