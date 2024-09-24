import SpriteKit

class Player: Entity {
    lazy var healthBar: HealthBar = {
        return HealthBar(health: getHealth(), maxHealth: getMaxHealth()).create()
    }()
    
    init(gameScene: SKScene?) {
        guard let scene = gameScene else {
            fatalError("Cannot initialise Player without a gameScene")
        }
        super.init(image: "spaceship", gameScene: scene)
        
        self.position = CGPoint(x: self.size.width + self.size.width / 2, y: self.size.height + self.size.height / 2)
        self.healthBar.setPosition(position: CGPoint(x: self.position.x, y: self.position.y - self.size.height))
        
        if let healthbar = self.healthBar.getHealthBar() {
            gameScene?.addChild(healthbar)
        }
        
        gameScene?.addChild(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateHealthBar() {
        self.healthBar = HealthBar.update(originalbar: self.healthBar, health: self.getHealth(), maxHealth: self.getMaxHealth())
        self.healthBar.setPosition(position: CGPoint(x: self.position.x, y: self.position.y - self.size.height))
        
        if let healthbar = self.healthBar.getHealthBar() {
            gameScene?.addChild(healthbar)
        }
    }
}
