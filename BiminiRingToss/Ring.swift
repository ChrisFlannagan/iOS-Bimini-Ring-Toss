//
//  Ring.swift
//  BiminiRingToss
//
//  Created by Christopher Flannagan on 8/19/17.
//  Copyright © 2017 Christopher Flannagan. All rights reserved.
//

import Foundation
import SceneKit

class Ring {
    
    var ring: SCNNode
    
    func getRing() -> SCNNode {
        return ring
    }
    
    init() {
        var geometry:SCNGeometry
        geometry = SCNTorus(ringRadius: 0.5, pipeRadius: 0.1)
        geometry.materials.first?.diffuse.contents = UIColor.blue
        ring = SCNNode(geometry: geometry)
        ring.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        ring.physicsBody?.mass = 5.0
    }
}
