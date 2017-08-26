//
//  Ceiling.swift
//  BiminiRingToss
//
//  Created by Christopher Flannagan on 8/25/17.
//  Copyright © 2017 Christopher Flannagan. All rights reserved.
//

import Foundation
import SceneKit

class Ceiling {
    
    var ceiling: SCNNode
    
    func getCeiling() -> SCNNode {
        return ceiling
    }
    
    init() {
        var geometry:SCNGeometry
        geometry = SCNBox(width: 50, height: 0.1, length: 50, chamferRadius: 0.0)
        geometry.materials.first?.diffuse.contents = UIColor.red
        ceiling = SCNNode(geometry: geometry)
        ceiling.position = SCNVector3(x: 0, y: 1, z: 0)
        
        let ceilingShape = SCNPhysicsShape(geometry: geometry, options: nil)
        let ceilingBody = SCNPhysicsBody(type: .static, shape: ceilingShape)
        ceiling.physicsBody = ceilingBody
    }
}
