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
    
    var holder: SCNNode
    var rope: SCNNode
    
    func getHolder() -> SCNNode {
        return holder
    }
    
    func getRope() -> SCNNode {
        return rope
    }
    
    init() {
        holder = SCNNode()
        
        var geometry:SCNGeometry
        
        geometry = SCNSphere(radius: 0.1)
        geometry.materials.first?.diffuse.contents = UIColor.blue
        
        rope = SCNNode(geometry: geometry)
        rope.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        rope.physicsBody?.mass = 5.0
        rope.physicsBody?.friction = 0.5;
    }
    
    func getLink( y:Float ) -> SCNNode {
        var geometry:SCNGeometry
        var link:SCNNode
        
        geometry = SCNSphere(radius: 0.1)
        geometry.materials.first?.diffuse.contents = UIColor.green
        
        link = SCNNode(geometry: geometry)
        link.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        link.physicsBody?.mass = 0.1
        link.physicsBody?.friction = 0;
        return link
    }
}
