//
//  DragonBallsController.swift
//  Load Board
//
//  Created by Tapan Patel on 08/09/21.
//  Copyright © 2021 Tapan Patel. All rights reserved.
//

import Foundation
import ARKit
import SceneKit

struct DragonBallsController
{
    static var lastDragonBall:Int = 1
    var loadedDragonBalls = false
    var dragonBalls:[SCNNode]
    init(with ludoBoardNode:SCNNode,and position:SCNVector3, addInScene sceneView : ARSCNView)
    {
        dragonBalls = [SCNNode]()
        guard let DBScene = SCNScene(named: Constants.Scenes.DragonBallScene) else {return}
        for i in 1...6
        {
            if let ballNode = DBScene.rootNode.childNode(withName: "\(Constants.Nodes.DragonBallNode)\(i)", recursively: false)
            {
//                ballNode.isHidden = false
//                ballNode.position = position
//                ballNode.position.y = position.y + 0.05
                ballNode.position = SCNVector3(0,0.1,0)
                ballNode.scale = SCNVector3Make(0.5, 0.5, 0.5)
                
                dragonBalls += [ballNode]
               // print("\(ballNode.name!) added to arrays")

            }
            else
            {
                print("Failed to add \(Constants.Nodes.DragonBallNode)\(i)")
            }
            
        }
        for ball in dragonBalls
        {
            ludoBoardNode.addChildNode(ball)
           // print("\(ball.name!) added to scene")
        }
        
     
    }
    
    
    
}
