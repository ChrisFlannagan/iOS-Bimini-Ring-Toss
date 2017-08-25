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
        scnScene.rootNode.addChildNode(ropeObject.getRope())
        
        var cnt:Float = 0.0
        var previousLink: SCNNode = ropeObject.getRope()
        while cnt < 1.0 {
            let link = ropeObject.getLink( y: Float(cnt) )
            previousLink.addChildNode( link )
            
            previousLink = link
            cnt += 0.1
        }
        /**
 let pinPosition = connectingRod.convert(pin.position,
 to: scene)
 let pinJoint = SKPhysicsJointPin.joint(withBodyA: pin.physicsBody!,
 bodyB: piston.physicsBody!,
 anchor: pinPosition)
 scene.physicsWorld.add(pinJoint)
 */
 
        let floorObject = Floor()
        scnScene.rootNode.addChildNode(floorObject.getFloor())
    }
}
