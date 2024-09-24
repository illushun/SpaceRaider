import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var engine: SpaceEngine!
    
    override func didMove(to view: SKView) {
        self.engine = SpaceEngine(scene: self)
        self.engine.testLog()
    }
}
