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
    init(with ludoBoardNode:SCNNode)
    {
        dragonBalls = [SCNNode]()
        guard let DBScene = SCNScene(named: Constants.Scenes.DragonBallScene) else {return}
        for i in 1...6
        {
            if let ballNode = DBScene.rootNode.childNode(withName: "\(Constants.Nodes.DragonBallNode)\(i)", recursively: false)
            {
                ballNode.position = SCNVector3(0,0.1,0)
                ballNode.scale = SCNVector3Make(0.5, 0.5, 0.5)
                ballNode.isHidden = true
                dragonBalls += [ballNode]
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
        dragonBalls[DragonBallsController.lastDragonBall].isHidden = false
        
        
    }
    
    mutating func animateBall(nextBallIndex:Int)
    {
        let prevIndex = DragonBallsController.lastDragonBall

//        print("\(dragonBalls[prevIndex].name!) should rotate and ball#\(dragonBalls[nextBallIndex].name!) should show")
                dragonBalls[prevIndex].runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 22, z: 0, duration: 0.2)))
        dragonBalls[prevIndex].runAction(SCNAction.scale(to: CGFloat.zero, duration: 0.3)){ [self] in
            self.dragonBalls[prevIndex].isHidden = true
            self.dragonBalls[nextBallIndex].scale = SCNVector3Zero
            self.dragonBalls[nextBallIndex].isHidden = false
            self.dragonBalls[nextBallIndex].runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 22, z: 0, duration: 0.2)))
            self.dragonBalls[nextBallIndex].runAction(SCNAction.scale(to: 0.5, duration: 0.3))
                    {
                self.dragonBalls[nextBallIndex].removeAllActions()
                        DragonBallsController.lastDragonBall = nextBallIndex

                    }
                }
    }
    
    
    
}
