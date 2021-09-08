//
//  LudoBoardController.swift
//  Load Board
//
//  Created by Tapan Patel on 08/09/21.
//  Copyright © 2021 Tapan Patel. All rights reserved.
//

import Foundation
import ARKit
import SceneKit
struct LudoBoardController
{
    //    let ludoBoard:LudoBoard?
    var isBoardLoaded:Bool
    var ludoBoard = SCNNode()
    init() {
        isBoardLoaded = false
        prepare([ludoBoard])
    }
    
    mutating func prepare(_ objects: [Any],
    completionHandler: ((Bool) -> Void)? = nil)
    {
        var boardNode = SCNNode()
        if let ludoScene = SCNScene(named: Constants.Scenes.ludoBoardScene)
        {
            boardNode = ludoScene.rootNode.childNode(withName: Constants.Nodes.LudoBoardNode, recursively: true)!
           ludoBoard = boardNode
        }
    }
    
    mutating func initializeLudoBoard(withNode node:SCNNode, andAnchor anchor:ARPlaneAnchor)
    {
        if !isBoardLoaded
        {
            ludoBoard.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
            node.addChildNode(self.ludoBoard)
            isBoardLoaded=true
            print("Board Loaded")
        }
        else{
            print("Not loaded")
        }
    }
    
    mutating func initializeLudoBoard(withPosition position:SCNVector3)
    {
       
            ludoBoard.position = position
            isBoardLoaded=true
            print("Board Loaded")
    }
}
