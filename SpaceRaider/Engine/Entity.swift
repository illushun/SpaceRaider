import SpriteKit

class Entity: SKSpriteNode {
    weak var gameScene: SKScene?
    
    var health: CGFloat = 100.0
    var maxHealth: CGFloat = 100.0
    
    var canShoot: Bool = true
    var cooldownTime: TimeInterval = 1.0
    
    init(image: String, gameScene: SKScene?) {
        let texture = SKTexture(imageNamed: image)
        super.init(texture: texture, color: .clear, size: texture.size())
        self.gameScene = gameScene
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
    
    // override this per entity
    func shoot() {
        canShoot = false
        self.cooldown()
    }
    
    func cooldown() {
        let waitAction = SKAction.wait(forDuration: cooldownTime)
        let enableShooting = SKAction.run { [weak self] in
            self?.canShoot = true
        }
        gameScene?.run(SKAction.sequence([waitAction, enableShooting]))
    }
    
    func takeDamage(_ damage: CGFloat) {
        if health <= 0.0 {
            self.removeFromParent()
        } else {
            health -= damage
        }
    }
}
