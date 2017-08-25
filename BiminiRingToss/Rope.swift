//
//  Rope.swift
//  BiminiRingToss
//
//  Created by Christopher Flannagan on 8/19/17.
//  Copyright © 2017 Christopher Flannagan. All rights reserved.
//

import Foundation
import SceneKit

class Rope {
    
    var rope: SCNNode
    
    func getRope() -> SCNNode {
        print(rope)
        return rope
    }
    
    init() {
        var geometry:SCNGeometry
        geometry = SCNSphere(radius: 0.2)
        geometry.materials.first?.diffuse.contents = UIColor.blue
        rope = SCNNode(geometry: geometry)
        rope.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
    }
    
    func getLink( y:Float ) -> SCNNode {
        var geometry:SCNGeometry
        var link:SCNNode
        geometry = SCNSphere(radius: 0.2)
        geometry.materials.first?.diffuse.contents = UIColor.green
        link = SCNNode(geometry: geometry)
        link.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        link.position = SCNVector3(x: 0, y: y, z: 0)
        return link
    }
}
