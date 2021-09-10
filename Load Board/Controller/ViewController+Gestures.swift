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
    //store previous coordinates from hittest to compare with current ones

    @objc func panGesture(_ sender:UIPanGestureRecognizer)
        {
            switch sender.state {
                case .began:
                    let hitNode = self.sceneView.hitTest(sender.location(in: self.sceneView),
                                                         options: nil)
                    self.PCoordx = (hitNode.first?.worldCoordinates.x)!
                    self.PCoordy = (hitNode.first?.worldCoordinates.y)!
                    self.PCoordz = (hitNode.first?.worldCoordinates.z)!
                case .changed:
                    // when you start to pan in screen with your finger
                    // hittest gives new coordinates of touched location in sceneView
                    // coord-pcoord gives distance to move or distance paned in sceneview
                    let hitNode = sceneView.hitTest(sender.location(in: sceneView), options: nil)
                    if let coordx = hitNode.first?.worldCoordinates.x,
                        let coordy = hitNode.first?.worldCoordinates.y,
                        let coordz = hitNode.first?.worldCoordinates.z {
                        let action = SCNAction.moveBy(x: CGFloat(coordx - PCoordx),
                                                      y: 0,
                                                      z: CGFloat(coordz - PCoordz),
                                                      duration: 0.0)
                        self.mainNode!.runAction(action)

                        self.PCoordx = coordx
                        self.PCoordy = coordy
                        self.PCoordz = coordz
                    }

                    sender.setTranslation(CGPoint.zero, in: self.sceneView)
                case .ended:
//                    print(phoneNode?.position)
                    self.PCoordx = 0.0
                    self.PCoordy = 0.0
                    self.PCoordz = 0.0
                default:
                    break
                }
        }
    
    @objc func handleTap( recognizer: UITapGestureRecognizer) {
        if !ludoBoardManager.isBoardLoaded, mainNode != nil
        {
            ludoBoardManager.initializeLudoBoard(withNode: mainNode!, withPosition:mainNode!.position)
            
            //dragonBallManager = DragonBallsController(with: ludoBoardManager.ludoBoard, and: mainNode!.position, addInScene: sceneView)
            diceManager = DiceController(ludoBoard: ludoBoardManager.ludoBoard)
            playerManager.createRedArmy(ludoBoard: ludoBoardManager.ludoBoard)
            playerManager.createGreenArmy(ludoBoard: ludoBoardManager.ludoBoard)
//            ludoBoardManager.ludoBoard.enumerateChildNodes { (child, nil) in
//                print(child.name)
//            }
//            
        }
        else
        {
            
            let touchLocation = recognizer.location(in: sceneView)
            let resultsOf3dTap = sceneView.hitTest(touchLocation, options: nil)
            if !resultsOf3dTap.isEmpty
            {
                guard let tapResultNode = resultsOf3dTap.first?.node else {return}
                if let ballName = tapResultNode.name, diceManager!.nodeTappedIsDragonballs(tappedNode: ballName)
                {
                 
               
                    print("DIce : \(Int.randomDiceNumber)")
                
                }
            }
        }
        
    }

}
