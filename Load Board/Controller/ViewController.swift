//
//  ViewController.swift
//  Load Board
//
//  Created by Tapan Patel on 30/05/20.
//  Copyright © 2020 Tapan Patel. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate ,SCNAnimationProtocol{
    
    @IBOutlet var sceneView: ARSCNView!
    
    var ludoBoardManager = LudoBoardController()
    
    func configureSceneView(trackPlanes planeDetection:Bool)
    {
        let configuration = ARWorldTrackingConfiguration()
        sceneView.showsStatistics = true
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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        configureSceneView(trackPlanes: true)
        guard let scene = SCNScene(named: Constants.Scenes.rootScene) else {
            print("Failed to Initialize rootScene")
            return
        }
        sceneView.scene = scene
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        sceneView.addGestureRecognizer(tapGesture)

    }
    
    
    
    
    
    @objc func handleTap( recognizer: UITapGestureRecognizer) {
        if !ludoBoardManager.isBoardLoaded
        {
            let tapLocation = recognizer.location(in: sceneView)
            let hitTestResults = sceneView.hitTest(tapLocation, types: .existingPlaneUsingExtent)
            
            guard let hitTestResult = hitTestResults.first else { return }
            let translation = hitTestResult.worldTransform.columns.3
            let x = translation.x
            let y = translation.y
            let z = translation.z
            ludoBoardManager.initializeLudoBoard(withPosition: SCNVector3(x,y,z))
            
            sceneView.scene.rootNode.addChildNode(ludoBoardManager.ludoBoard)
        }
        else
        {
            print("Board Already Loaded!")
        }
        
    }
    
   
    
//    
//    @objc func scalePiece(_ gestureRecognizer : UIPinchGestureRecognizer)
//    {
//        guard gestureRecognizer.view != nil else { return }
//        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed
//        {
//            //        MainNode.scale = SCNVector3(gestureRecognizer.scale, gestureRecognizer.scale, gestureRecognizer.scale)
//            //        gestureRecognizer.scale = 1.0
////            scaleMainNode(with: SCNVector3(0.1,0.1,0.1))
//
//            let pinchScaleX: CGFloat = gestureRecognizer.scale * CGFloat((MainNode.scale.x))
//                    let pinchScaleY: CGFloat = gestureRecognizer.scale * CGFloat((MainNode.scale.y))
//                    let pinchScaleZ: CGFloat = gestureRecognizer.scale * CGFloat((MainNode.scale.z))
//            MainNode.scale = SCNVector3Make(Float(pinchScaleX), Float(pinchScaleY), Float(pinchScaleZ))
//            gestureRecognizer.scale = 1
//            //        MainNode.removeFromParentNode()
//            //        sceneView.scene.rootNode.addChildNode(MainNode)
//            //        print("MainNode : \(MainNode.scale)")
//            //        print("RootNode : \(sceneView.scene.rootNode.scale)")
//
//        }
//        if gestureRecognizer.state == .ended { }
//
//    }
  
    
    
   
    
    
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    
    
    
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor)
    {
        
        if let planeAnchor = anchor as? ARPlaneAnchor
        {
//            ludoBoardManager.initializeLudoBoard(withNode: node, andAnchor: planeAnchor)
//            configureSceneView(trackPlanes: false)
            let width = CGFloat(planeAnchor.extent.x)
               let height = CGFloat(planeAnchor.extent.z)
               let plane = SCNPlane(width: width, height: height)
               
               // 3
            plane.materials.first?.diffuse.contents = UIColor.red
            plane.materials.first?.transparency = 0.2
               
               // 4
               let planeNode = SCNNode(geometry: plane)
               
               // 5
               let x = CGFloat(planeAnchor.center.x)
               let y = CGFloat(planeAnchor.center.y)
               let z = CGFloat(planeAnchor.center.z)
               planeNode.position = SCNVector3(x,y,z)
               planeNode.eulerAngles.x = -.pi / 2
               
               // 6
               node.addChildNode(planeNode)
            
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
extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

extension Float {
    
    var RadiansToDegree: Float { return Float(self) / .pi*180}
}


