//
//  Ring.swift
//  BiminiRingToss
//
//  Created by Christopher Flannagan on 8/19/17.
//  Copyright © 2017 Christopher Flannagan. All rights reserved.
//

import Foundation
import SceneKit

class Floor {
    
    var floor: SCNNode
    
    func getFloor() -> SCNNode {
        return floor
    }
    
    init() {
        var geometry:SCNGeometry
        geometry = SCNFloor()
        geometry.materials.first?.diffuse.contents = UIColor.brown
        floor = SCNNode(geometry: geometry)
        floor.position = SCNVector3(x: 0, y: -15, z: 0)
        
        let floorShape = SCNPhysicsShape(geometry: geometry, options: nil)
        let floorBody = SCNPhysicsBody(type: .static, shape: floorShape)
        floor.physicsBody = floorBody
    }
}
