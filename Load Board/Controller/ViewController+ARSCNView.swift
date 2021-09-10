//
//  ViewController+ARSCNView.swift
//  Load Board
//
//  Created by Tapan Patel on 09/09/21.
//  Copyright © 2021 Tapan Patel. All rights reserved.
//

import Foundation
import ARKit
import SceneKit
extension ViewController :  ARSCNViewDelegate ,SCNAnimationProtocol
{
    func addShadow()
    {
        // DIRECTIONAL LIGHT for `primary light rays` simulation
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .directional
        lightNode.light!.castsShadow = true
        lightNode.light!.shadowMode = .deferred
        lightNode.light!.categoryBitMask = -1
        lightNode.light!.automaticallyAdjustsShadowProjection = true
        //lightNode.light!.maximumShadowDistance = 11000
        lightNode.position = SCNVector3(x: 0, y: -5000, z: 0)
        lightNode.rotation = SCNVector4(x: -1, y: 0, z: 0, w: .pi/2)
        sceneView.scene.rootNode.addChildNode(lightNode)
    }
    
    func configureSceneView(trackPlanes planeDetection:Bool)
    {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.showsStatistics = true
        configuration.environmentTexturing = .automatic
      //  addShadow()
        sceneView.debugOptions = [.showFeaturePoints,.showFeaturePoints]
        if planeDetection
        {
            configuration.planeDetection = .horizontal
        }
        else
        {
            configuration.planeDetection = []
        }
        sceneView.session.run(configuration)
        sceneView.autoenablesDefaultLighting = true
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor)
    {
        
        if let planeAnchor = anchor as? ARPlaneAnchor
        {
            let width = CGFloat(planeAnchor.extent.x)
            let height = CGFloat(planeAnchor.extent.z)
            let plane = SCNPlane(width: width, height: height)
            
            // 3
            plane.materials.first?.diffuse.contents = UIColor.red
            plane.materials.first?.transparency = 0
            
            // 4
            let planeNode = SCNNode(geometry: plane)
            
            // 5
            let x = CGFloat(planeAnchor.center.x)
            let y = CGFloat(planeAnchor.center.y)
            let z = CGFloat(planeAnchor.center.z)
            planeNode.position = SCNVector3(x,y,z)
            planeNode.eulerAngles.x = -.pi / 2
            
            // 6
            mainNode = planeNode
            sceneView.scene.rootNode.addChildNode(mainNode!)
            node.name = Constants.Nodes.detectedNode
            node.addChildNode(mainNode!)
            configureSceneView(trackPlanes: false)
            
        }
        else
        {
            return
        }
        
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        // 1
        guard let planeAnchor = anchor as?  ARPlaneAnchor,
              let planeNode = node.childNodes.first,
              let plane = planeNode.geometry as? SCNPlane
        else { return }
        
        // 2
        let width = CGFloat(planeAnchor.extent.x)
        let height = CGFloat(planeAnchor.extent.z)
        plane.width = width
        plane.height = height
        
        // 3
        let x = CGFloat(planeAnchor.center.x)
        let y = CGFloat(planeAnchor.center.y)
        let z = CGFloat(planeAnchor.center.z)
        planeNode.position = SCNVector3(x, y, z)
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
