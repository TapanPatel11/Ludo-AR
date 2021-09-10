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
            ludoBoard.name = "LudoBoardNode"
        }
    }
    
    mutating func initializeLudoBoard(withNode node:SCNNode)
    {
        if !isBoardLoaded
        {
            
            ludoBoard.position = node.position
            node.addChildNode(self.ludoBoard)
            isBoardLoaded=true           
        }
        else{
            print("Not loaded")
        }
    }
    
}
