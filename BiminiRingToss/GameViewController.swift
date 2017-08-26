import UIKit
import SceneKit

class GameViewController: UIViewController, SCNSceneRendererDelegate {
    
    var scnView: SCNView!
    var scnScene: SCNScene!
    var cameraNode: SCNNode!
    var theRing: SCNNode!
    var ringObject: Ring!
    
    var holdingTouch: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        holdingTouch = false
        
        /** Setup our scene and spawn our nodes **/
        setupView()
        setupScene()
        setupCamera()
        setupLight()
        spawnNodes()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            holdingTouch = true
        }
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil {
            holdingTouch = false
        }
        super.touchesBegan(touches, with: event)
    }
    
    func renderer(_ renderer: SCNSceneRenderer,
                  updateAtTime time: TimeInterval){
        if ( holdingTouch ) {
            ringObject.hold()
        }
    }
    
    
    func setupView() {
        scnView = self.view as! SCNView
        scnView.showsStatistics = true
        scnView.allowsCameraControl = true
        scnView.autoenablesDefaultLighting = true
        scnView.delegate = self
    }
    
    func setupScene() {
        scnScene = SCNScene()
        scnView.scene = scnScene
    }
    
    func setupCamera() {
        cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: -2, z: 12)
        cameraNode.eulerAngles = SCNVector3(-0.2, 0, 0)
        scnScene.rootNode.addChildNode(cameraNode)
    }
    
    func setupLight() {
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        ambientLightNode.light!.color = UIColor(white: 0.67, alpha: 1.0)
        scnScene.rootNode.addChildNode(ambientLightNode)
    }
    
    func spawnNodes() {
        ringObject = Ring()
        theRing = ringObject.getRing()
        let ropeObject = Rope()
        
        /** Setup ceiling and floor **/
        let ceilingObject = Ceiling()
        let floorObject = Floor()
        let anchor = SCNPhysicsBallSocketJoint(bodyA: ropeObject.getRope().physicsBody!, anchorA: SCNVector3( -0.05, -0.05, -0.05), bodyB: ceilingObject.getCeiling().physicsBody!, anchorB: SCNVector3(0, -0.1, 0))
        scnScene.physicsWorld.addBehavior(anchor)
        
        /** Generate our rope links **/
        var cnt:Float = 0.0
        var previousLink: SCNNode = ropeObject.getRope()
        var links :[SCNNode] = [SCNNode]()
        while cnt < 4.0 {
            let link = ropeObject.getLink( y: Float(cnt) )
            links.append(link)
            
            let joint = SCNPhysicsBallSocketJoint(
                bodyA: link.physicsBody!,
                anchorA: SCNVector3(x: -0.05, y: -0.05, z: -0.05),
                bodyB: previousLink.physicsBody!,
                anchorB: SCNVector3(x: 0.05, y: 0.05, z: 0.05)
            )
            scnScene.physicsWorld.addBehavior(joint)
            
            previousLink = link
            cnt += 0.1
        }
    
        /** Attach Ring to end of Rope **/
        let joint = SCNPhysicsBallSocketJoint(
            bodyA: theRing.physicsBody!,
            anchorA: SCNVector3(x: 0.6 , y: 0, z: 0),
            bodyB: previousLink.physicsBody!,
            anchorB: SCNVector3(x: 0.05, y: 0.05, z: 0.05)
        )
        scnScene.physicsWorld.addBehavior(joint)
        
        /** Add All Nodes To Scene **/
        scnScene.rootNode.addChildNode(ropeObject.getHolder())
        ropeObject.getHolder().addChildNode(ceilingObject.getCeiling())
        ropeObject.getHolder().addChildNode(ropeObject.getRope())
        links.forEach { link in
            ropeObject.getHolder().addChildNode( link )
        }
        scnScene.rootNode.addChildNode(theRing)
        scnScene.rootNode.addChildNode(floorObject.getFloor())
    }
}
