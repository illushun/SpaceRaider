import SpriteKit

class Voyager: NSObject, SKPhysicsContactDelegate {
    weak var scene: SKScene?
    
    // Physics
    var gravity: CGFloat = 1.0
    
    // Other Game Related Vars
    var gameOver: Bool = false
    var score: Int = 0 {
        didSet {
            // do score label here
        }
    }
    var points: Int = 0 {
        didSet {
            // do points label here
            UserDefaults.standard.set(points, forKey: "points")
        }
    }
    
    init(scene: SKScene) {
        // need this for the NSObject
        super.init()
        
        self.scene = scene
    }
    
    /* Getters */
    
    func getGravity() -> CGFloat {
        return self.gravity
    }
    
    /* Setters */
    
    func setGravity(gravity: CGFloat) {
        self.gravity = gravity
    }
    
    func testLog() {
        print("Sent from the SpaceEngine!!")
    }
}
