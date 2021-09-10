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

class ViewController: UIViewController{
    
    @IBOutlet var sceneView: ARSCNView!
    var PCoordx: Float = 0.0
    var PCoordy: Float = 0.0
    var PCoordz: Float = 0.0
    var ludoBoardManager = LudoBoardController()
    var diceManager:DiceController?
    var playerManager = PlayerController()
    var mainNode :SCNNode?
    
//MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        mainNode?.name = "SceneRootNode"
        sceneView.delegate = self
        configureSceneView(trackPlanes: true)
        guard let scene = SCNScene(named: Constants.Scenes.rootScene) else {
            print("Failed to Initialize rootScene")
            return
        }
        sceneView.scene = scene
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGesture(_:)))
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(with:)))
        
        sceneView.addGestureRecognizer(tapGesture)
        sceneView.addGestureRecognizer(panGesture)
        sceneView.addGestureRecognizer(pinchGesture)
    }
    
    
 
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
}
extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
    static var randomDiceNumber : Int
    {
        return Int(arc4random_uniform(6) + 1)
    }
}

extension Float {
    
    var RadiansToDegree: Float { return Float(self) / .pi*180}
}

