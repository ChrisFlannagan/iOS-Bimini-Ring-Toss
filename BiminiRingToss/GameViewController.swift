import UIKit
import SceneKit

class GameViewController: UIViewController {
    
    var scnView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupScene()
        setupCamera()
        spawnNodes()
    }
    
    func setupView() {
        scnView = self.view as! SCNView
        scnView.showsStatistics = true
        scnView.allowsCameraControl = true
        scnView.autoenablesDefaultLighting = true
    }
    
    func setupScene() {
        scnScene = SCNScene()
        scnView.scene = scnScene
    }
    
    func setupCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: -5, z: 10)
        cameraNode.eulerAngles = SCNVector3(-0.2, 0, 0);
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    func spawnNodes() {
        let ringObject = Ring()
        scnScene.rootNode.addChildNode(ringObject.getRing())
        
        let ropeObject = Rope()
        scnScene.rootNode.addChildNode(ropeObject.getHolder())
        ropeObject.getHolder().addChildNode(ropeObject.getRope())
        
        var cnt:Float = 0.0
        var previousLink: SCNNode = ropeObject.getRope()
        while cnt < 4 {
            let link = ropeObject.getLink( y: Float(cnt) )
            ropeObject.getHolder().addChildNode( link )
            let joint = SCNPhysicsBallSocketJoint(
                bodyA: link.physicsBody!,
                anchorA: link.position,
                bodyB: previousLink.physicsBody!,
                anchorB: previousLink.position
            )
            scnScene.physicsWorld.addBehavior(joint)
            
            previousLink = link
            cnt += 0.1
        }
 
        let floorObject = Floor()
        scnScene.rootNode.addChildNode(floorObject.getFloor())
    }
}
