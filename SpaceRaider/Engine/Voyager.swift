import SpriteKit

class Voyager: NSObject, SKPhysicsContactDelegate {
    weak var scene: SKScene?
    
    // Entities
    var enemy: Enemy!
    var player: Player!
    
    // Physics
    var gravity: CGFloat = 1.0
    
    // Other Game Related Vars
    var gameOver: Bool = false
    var score: Int = 0
    var scoreMultiplier: CGFloat = 1.0
    var points: Int = 0
    
    init(scene: SKScene) {
        // need this for the NSObject
        super.init()
        
        self.scene = scene
        
        self.player = Player(gameScene: scene)
        self.enemy = Enemy(position: CGPoint(x: scene.size.width  / 2, y: scene.size.height / 2 + self.player.size.height), gameScene: scene)
        
        self.scene?.view?.showsPhysics = true
    }
    
    /* Getters */
    
    func getGravity() -> CGFloat {
        return self.gravity
    }
    
    func getScore() -> Int {
        return self.score
    }
    
    func getScoreMultiplier() -> CGFloat {
        return self.scoreMultiplier
    }
    
    func getPoints() -> Int {
        return self.points
    }
    
    /* Setters */
    
    func setGravity(gravity: CGFloat) {
        self.gravity = gravity
    }
    
    func testLog() {
        print("[Voyager] START UP!!")
    }
    
    /* Do Stuff */
    
    func update() {
        self.player.updateHealthBar()
        self.enemy.updateHealthBar()
    }
    
    func touchesBegan(location: CGPoint, node: SKNode) {
        print("[Voyager] Touch detected at: \(location)")
        
        if node.name == "fireButton" {
            print("[Voyager] Player shooting...")
            self.player.shoot()
        } else if node.name == "pauseButton" {
            print("[Voyager] Pausing game...")
        } else {
            print("[Voyager] Moving player...")
            self.player.move(to: CGPoint(x: location.x, y: location.y))
        }
    }
    
    func didBegin(firstBody: SKPhysicsBody, secondBody: SKPhysicsBody) {
        if firstBody.categoryBitMask == projectileCategory && secondBody.categoryBitMask == enemyCategory {
            if let enemy = secondBody.node as? Enemy {
                firstBody.node?.removeFromParent()
                enemy.takeDamage(1000.0)
                print("TEST!!")
            }
        } else if firstBody.categoryBitMask == playerCategory && secondBody.categoryBitMask == enemyCategory {
            // Player hit by enemy
            self.player.takeDamage(10.0)
        }
    }
}
