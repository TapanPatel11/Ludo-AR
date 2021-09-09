//
//  ViewController+Gestures.swift
//  Load Board
//
//  Created by Tapan Patel on 09/09/21.
//  Copyright © 2021 Tapan Patel. All rights reserved.
//

import Foundation
import UIKit
import ARKit
import SceneKit
extension ViewController
{
    @objc func handlePinch(with gestureRecognizer : UIPinchGestureRecognizer)
    {
        
        guard gestureRecognizer.view != nil else { return }
        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed
        {
            let MainNode = ludoBoardManager.ludoBoard
            let pinchScaleX: CGFloat = gestureRecognizer.scale * CGFloat((MainNode.scale.x))
            let pinchScaleY: CGFloat = gestureRecognizer.scale * CGFloat((MainNode.scale.y))
            let pinchScaleZ: CGFloat = gestureRecognizer.scale * CGFloat((MainNode.scale.z))
            MainNode.scale = SCNVector3Make(Float(pinchScaleX), Float(pinchScaleY), Float(pinchScaleZ))
            gestureRecognizer.scale = 1
            
        }
        if gestureRecognizer.state == .ended { }
        
        
    }
    
    
    
    @objc func handleTap( recognizer: UITapGestureRecognizer) {
        if !ludoBoardManager.isBoardLoaded, mainNode != nil
        {
            ludoBoardManager.initializeLudoBoard(withNode: mainNode!, withPosition:mainNode!.position)
            dragonBallManager = DragonBallsController(with: ludoBoardManager.ludoBoard, and: mainNode!.position, addInScene: sceneView)
            playerManager.createRedArmy(ludoBoard: ludoBoardManager.ludoBoard)
            playerManager.createGreenArmy(ludoBoard: ludoBoardManager.ludoBoard)
//            ludoBoardManager.ludoBoard.enumerateChildNodes { (child, nil) in
//                print(child.name)
//            }
//            
        }
        else
        {
            
            
            //print("Board Already Loaded!")
        }
        
    }

}
