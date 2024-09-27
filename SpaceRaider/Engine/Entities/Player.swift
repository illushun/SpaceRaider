import SpriteKit

class Player: Entity {
    lazy var healthBar: HealthBar = {
        return HealthBar(health: getHealth(), maxHealth: getMaxHealth()).create()
    }()
    
    init(gameScene: SKScene?) {
        guard let scene = gameScene else {
            fatalError("Cannot initialise Player without a gameScene")
        }
        super.init(image: "spaceship", bitmask: playerCategory, gameScene: scene)
        
        self.position = CGPoint(x: scene.size.width  / 2, y: scene.size.height / 2)
        self.healthBar.setPosition(position: CGPoint(x: self.position.x, y: self.position.y - self.size.height))
        
        if let healthbar = self.healthBar.getHealthBar() {
            if (self.health > 0.0) {
                gameScene?.addChild(healthbar)
            }
        }
        
        gameScene?.addChild(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func shoot() {
        if (!self.getCanShoot()) { return }
        
        canShoot = false  // Set cooldown to false immediately

        let missile = Missile(position: self.position, gameScene: self.gameScene)
        
        // Move the projectile up
        if let gameScene = missile.gameScene {
            let moveAction = SKAction.moveTo(y: gameScene.size.height + missile.size.height, duration: 1.0)
            let removeAction = SKAction.removeFromParent()
            missile.run(SKAction.sequence([moveAction, removeAction]))
        }

        self.cooldown()
    }
    
    func updateHealthBar() {
        self.healthBar = HealthBar.update(originalbar: self.healthBar, health: self.getHealth(), maxHealth: self.getMaxHealth())
        self.healthBar.setPosition(position: CGPoint(x: self.position.x, y: self.position.y - self.size.height))
        
        if let healthbar = self.healthBar.getHealthBar() {
            gameScene?.addChild(healthbar)
        }
    }
}
