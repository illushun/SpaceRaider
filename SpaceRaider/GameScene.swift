import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var engine: Voyager!
    
    var testent: Entity!
    var player: Player!
    
    override func didMove(to view: SKView) {
        self.engine = Voyager(scene: self)
        self.engine.testLog()
        
        self.player = Player(gameScene: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        super.update(currentTime)
        
        self.player.takeDamage(0.1)
        self.player.updateHealthBar()
    }
}
