import SpriteKit

class Enemy: Entity {
    lazy var healthBar: HealthBar = {
        return HealthBar(health: getHealth(), maxHealth: getMaxHealth()).create()
    }()
    
    init(position: CGPoint, gameScene: SKScene?) {
        guard let scene = gameScene else {
            fatalError("Cannot initialise Player without a gameScene")
        }
        super.init(image: "enemy", bitmask: enemyCategory, gameScene: scene)
        
        self.position = position
        self.healthBar.setPosition(position: CGPoint(x: self.position.x, y: self.position.y - self.size.height))
        
        if let healthbar = self.healthBar.getHealthBar() {
            gameScene?.addChild(healthbar)
        }
        
        gameScene?.addChild(self)
        
        // some custom physics setup for enemies
        self.physicsBody?.contactTestBitMask = projectileCategory | playerCategory
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateHealthBar() {
        self.healthBar = HealthBar.update(originalbar: self.healthBar, health: self.getHealth(), maxHealth: self.getMaxHealth())
        self.healthBar.setPosition(position: CGPoint(x: self.position.x, y: self.position.y - self.size.height))
        
        if let healthbar = self.healthBar.getHealthBar() {
            if (self.health > 0.0) {
                gameScene?.addChild(healthbar)
            }
        }
    }
    
    override func takeDamage(_ damage: CGFloat) {
        self.health -= damage
        if health <= 0.0 {
            self.removeFromParent()
            self.healthBar.healthBarNode?.removeFromParent()
            self.health = 0.0
        }
    }
}
