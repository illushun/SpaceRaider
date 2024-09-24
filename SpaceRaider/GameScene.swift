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
        
        self.player.takeDamage(0.1)
        self.player.updateHealthBar()
        
        print(self.player.position)
    }
}
