import SpriteKit

class Player: Entity {
    lazy var healthBar: SKShapeNode = {
        return SpaceUI.createHealthBar(health: getHealth(), maxHealth: getMaxHealth(), size: CGSize(width: 100, height: 10))
    }()
    
    init(gameScene: SKScene?) {
        guard let scene = gameScene else {
            fatalError("Cannot initialise Player without a gameScene")
        }
        super.init(image: "spaceship", gameScene: scene)
        
        self.position = CGPoint(x: self.size.width + self.size.width / 2, y: self.size.height + self.size.height / 2)
        self.healthBar.position = CGPoint(x: self.position.x, y: self.position.y)
        
        gameScene?.addChild(self.healthBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateHealthBar() {
        self.healthBar.removeFromParent()
        
        self.healthBar = SpaceUI.createHealthBar(health: getHealth(), maxHealth: getMaxHealth(), size: CGSize(width: 100, height: 10))
        self.healthBar.position = CGPoint(x: self.position.x, y: self.position.y)
        gameScene?.addChild(self.healthBar)
    }
}
