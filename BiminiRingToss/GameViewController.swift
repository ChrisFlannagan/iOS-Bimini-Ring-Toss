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
        
        var cnt:Float = 0.0
        var previousLink: SCNNode = ropeObject.getRope()
        var links :[SCNNode] = [SCNNode]()
        while cnt < 0.7 {
            let link = ropeObject.getLink( y: Float(cnt) )
            links.append(link)
            
            let joint = SCNPhysicsBallSocketJoint(
                bodyA: link.physicsBody!,
                anchorA: SCNVector3(x: 0, y: -0.05, z: 0),
                bodyB: previousLink.physicsBody!,
                anchorB: SCNVector3(x: 0, y: 0.05, z: 0)
            )
            scnScene.physicsWorld.addBehavior(joint)
            
            previousLink = link
            cnt += 0.1
        }
    
        /** Attach Ring to end of Rope **/
        let joint = SCNPhysicsBallSocketJoint(
            bodyA: ringObject.getRing().physicsBody!,
            anchorA: SCNVector3(x: 0, y: 0.05, z: 0),
            bodyB: previousLink.physicsBody!,
            anchorB: SCNVector3(x: 0, y: 0, z: 0)
        )
        scnScene.physicsWorld.addBehavior(joint)
        
        /** Setup ceiling and floor **/
        //TODO: Move cieling to a class
        let ceiling = SCNBox(width: 10, height: 0.1, length: 10, chamferRadius: 0.0)
        ceiling.firstMaterial?.diffuse.contents = UIColor.blue
        let ceilingNode = SCNNode(geometry: ceiling)
        ceilingNode.physicsBody = SCNPhysicsBody(type: .static, shape: SCNPhysicsShape.init(geometry: ceiling, options: nil))
        ceilingNode.position = SCNVector3(0.0, 2, 0)
        let anchor = SCNPhysicsBallSocketJoint(bodyA: ringObject.getRing().physicsBody!, anchorA: SCNVector3(0, -0.05, 0), bodyB: ceilingNode.physicsBody!, anchorB: SCNVector3(0, 0.05, 0))
        scnScene.physicsWorld.addBehavior(anchor)
        
        //let floorObject = Floor()
        //scnScene.rootNode.addChildNode(floorObject.getFloor())
        
        scnScene.rootNode.addChildNode(ropeObject.getHolder())
        ropeObject.getHolder().addChildNode(ceilingNode)
        ropeObject.getHolder().addChildNode(ropeObject.getRope())
        links.forEach { link in
            ropeObject.getHolder().addChildNode( link )
        }
    }
}
