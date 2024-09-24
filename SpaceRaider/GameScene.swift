import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var engine: Voyager!
    
    var testent: Entity!
    var player: Player!
    
    // UI
    var scoreLabel: SKLabelNode!
    var pointsLabel: SKLabelNode!
    var testLabel: SKLabelNode!
    
    override func didMove(to view: SKView) {
        self.engine = Voyager(scene: self)
        self.engine.testLog()
        
        self.scoreLabel = SpaceUI.label(text: "Score: \(self.engine.getScore())", position: CGPoint(x: 80, y: self.size.height - 80), color: .white)
        self.pointsLabel = SpaceUI.label(text: "Points: \(self.engine.getPoints())", position: CGPoint(x: 80, y: self.size.height - 110), color: .white)
        self.testLabel = SpaceUI.label(text: "VoyagerEngine Dev Environment", position: CGPoint(x: self.size.width / 2, y: 50), color: .white)
        
        self.player = Player(gameScene: self)
        
        addChild(self.scoreLabel)
        addChild(self.pointsLabel)
        addChild(self.testLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        print("Touch detected at: \(location)")
        
        if let player = player {
            player.move(to: CGPoint(x: location.x, y: location.y))
        } else {
            print("Player is not initialised!")
        }
    }

    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        if (self.player.getHealth() > 80.0) {
            self.player.takeDamage(0.1)
        }
        self.player.updateHealthBar()
    }
}
