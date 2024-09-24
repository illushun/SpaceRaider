import SpriteKit

class SpaceEngine: NSObject, SKPhysicsContactDelegate {
    weak var scene: SKScene?
    
    var gravity = 1.0
    
    init(scene: SKScene) {
        // need this for the NSObject
        super.init()
        
        self.scene = scene
    }
    
    func testLog() {
        print("Sent from the SpaceEngine!!")
    }
}
