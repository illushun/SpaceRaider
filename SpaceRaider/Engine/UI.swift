import SpriteKit

class SpaceUI {
    private static let FONT_NAME = "AvenirNext-Bold"
    
    static func createHealthBar(health: CGFloat, maxHealth: CGFloat, size: CGSize) -> SKShapeNode {
        let healthPercentage = health / maxHealth
        let healthBarWidth = size.width * healthPercentage
        
        // background
        let background = SKShapeNode(rectOf: size, cornerRadius: size.height / 2)
        background.fillColor = .red
        background.strokeColor = .clear
        
        // foreground
        let foreground = SKShapeNode(rectOf: CGSize(width: healthBarWidth, height: size.height), cornerRadius: size.height / 2)
        foreground.fillColor = .green
        foreground.strokeColor = .clear
        
        // merge both bars
        let healthBarNode = SKShapeNode(rectOf: size, cornerRadius: size.height / 2)
        healthBarNode.addChild(background)
        healthBarNode.addChild(foreground)
        
        // position foreground ontop of background
        foreground.position = CGPoint(x: -(size.width - healthBarWidth) / 2, y: 0)
        
        return healthBarNode
    }
    
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
