import SpriteKit

class HealthBar {
    var healthBarNode: SKShapeNode?
    
    var size = CGSize(width: 100, height: 10)
    var health: CGFloat
    var maxHealth: CGFloat
    
    var healthPercentage: CGFloat
    
    init(health: CGFloat, maxHealth: CGFloat) {
        self.health = health
        self.maxHealth = maxHealth
        
        self.healthPercentage = self.health / maxHealth
    }
    
    private func remove() {
        self.getHealthBar()?.removeFromParent()
    }
    
    /* Getters */
    
    func getSize() -> CGSize {
        return self.size
    }
    
    func getHealthBar() -> SKShapeNode? {
        return self.healthBarNode
    }
    
    func getPosition() -> CGPoint? {
        self.getHealthBar()?.position
    }
    
    /* Setters */
    
    func setSize(size: CGSize) -> HealthBar {
        self.size = size
        return self
    }
    
    func setPosition(position: CGPoint) -> HealthBar {
        self.getHealthBar()?.position = position
        return self
    }
    
    func create() -> HealthBar {
        let healthBarWidth = self.size.width * self.healthPercentage
        
        // background
        let background = SKShapeNode(rectOf: self.size, cornerRadius: self.size.height / 2)
        background.fillColor = .red
        background.strokeColor = .clear
        
        // foreground
        let foreground = SKShapeNode(rectOf: CGSize(width: healthBarWidth, height: self.size.height), cornerRadius: self.size.height / 2)
        foreground.fillColor = .green
        foreground.strokeColor = .clear
        
        // merge both bars
        self.healthBarNode = SKShapeNode(rectOf: self.size, cornerRadius: self.size.height / 2)
        self.healthBarNode?.addChild(background)
        self.healthBarNode?.addChild(foreground)
        
        foreground.position = CGPoint(x: -(self.size.width - healthBarWidth) / 2, y: 0)
        return self
    }
    
    static func update(originalbar: HealthBar, health: CGFloat, maxHealth: CGFloat) -> HealthBar {
        let originalSize = originalbar.getSize()
        originalbar.remove()
        
        if let position = originalbar.getPosition() {
            return HealthBar(health: health, maxHealth: maxHealth).setSize(size: originalSize).create().setPosition(position: position)
        } else {
            return HealthBar(health: health, maxHealth: maxHealth).setSize(size: originalSize).create()
        }
    }
}

class SpaceUI {
    private static let FONT_NAME = "AvenirNext-Bold"
    
    /* General UI Components */
    
    static func button(text: String, position: CGPoint, color: UIColor, nodeName: String) -> SKLabelNode {
        let button = SKLabelNode(fontNamed: FONT_NAME)
        button.fontSize = 20
        button.position = position
        button.color = color
        button.text = text
        button.name = nodeName // used for checking if the button was pressed
        
        return button
    }
    
    static func label(text: String, position: CGPoint, color: UIColor) -> SKLabelNode {
        let label = SKLabelNode(fontNamed: FONT_NAME)
        label.fontSize = 20
        label.fontColor = color
        label.position = position
        label.text = text
        
        return label
    }
}
