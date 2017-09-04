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
    var links :[SCNNode] = [SCNNode]()
    
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
    }
    
    func getLink( y:Float ) -> SCNNode {
        var geometry:SCNGeometry
        var link:SCNNode
        
        geometry = SCNSphere(radius: 0.1)
        geometry.materials.first?.diffuse.contents = UIColor.green
        
        link = SCNNode(geometry: geometry)
        link.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        link.physicsBody?.mass = 1.0
        return link
    }
    
    func clampLinks() {
        var previousLink: SCNNode = rope
        links.forEach { link in
            let origPos: SCNVector3 = previousLink.position
            let newPos: SCNVector3 = link.position
            var dist = (newPos.x - origPos.x) * (newPos.x - origPos.x) + (newPos.y - origPos.y) * (newPos.y - origPos.y) + (newPos.z - origPos.z) * (newPos.z - origPos.z)
            dist = dist.squareRoot()
            let midPoint = SCNVector3Make((newPos.x + origPos.x)/2, (newPos.y + origPos.y)/2, (newPos.z + origPos.z)/2)
            
            if ( dist > 0.1 ) {
                print(dist)
                link.position = midPoint
            }
            previousLink = link
        }

    }
}
