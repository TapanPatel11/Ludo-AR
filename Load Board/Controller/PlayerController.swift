//
//  PlayerController.swift
//  Load Board
//
//  Created by Tapan Patel on 09/09/21.
//  Copyright © 2021 Tapan Patel. All rights reserved.
//

import Foundation
import ARKit
import SceneKit
struct PlayerController {
    var redArmy : [Player]
    var greenArmy : [Player]
    init ()
    {
        redArmy = [Player]()
        greenArmy = [Player]()
        
    }
    
    mutating   func createRedArmy(ludoBoard: SCNNode)
    {
        //    let RedArmyRootNode = SCNNode()
        
        let player1 = Player(ludoBoard: ludoBoard, position: SCNVector3(-0.11,0,0.1),
                             ArmyType: Constants.Army.red, number: 1, Scene: Constants.Scenes.KidBuuScene, NodeName: Constants.Nodes.KidBuu, animatedNode: Constants.Nodes.KidAnimatedNode, childNamesToBeReplaced: Constants.Nodes.kidChilds)
        
        //x: -0.07, y: 0, z: 0.067
        let player2 = Player(ludoBoard: ludoBoard, position : SCNVector3(-0.07,0,0.1),ArmyType: Constants.Army.red, number: 2, Scene: Constants.Scenes.KidBuuScene, NodeName: Constants.Nodes.KidBuu, animatedNode: Constants.Nodes.KidAnimatedNode, childNamesToBeReplaced: Constants.Nodes.kidChilds)
        
        //x: -0.1, y: 0, z: 0.067
        let player3 = Player(ludoBoard: ludoBoard, position : SCNVector3(-0.07,0,0.07),ArmyType: Constants.Army.red, number: 3, Scene: Constants.Scenes.KidBuuScene, NodeName: Constants.Nodes.KidBuu, animatedNode: Constants.Nodes.KidAnimatedNode, childNamesToBeReplaced: Constants.Nodes.kidChilds)
        
        //x: -0.1, y: 0, z: 0.1
        let player4 = Player(ludoBoard: ludoBoard, position : SCNVector3(-0.11,0,0.07), ArmyType: Constants.Army.red, number: 4, Scene: Constants.Scenes.KidBuuScene, NodeName: Constants.Nodes.KidBuu, animatedNode: Constants.Nodes.KidAnimatedNode, childNamesToBeReplaced: Constants.Nodes.kidChilds)
        redArmy += [player1,player2,player3,player4]
        for redPlayer in redArmy
        {
            ludoBoard.addChildNode(redPlayer.playerNode!)
            
        }
    }
    
    mutating   func createGreenArmy(ludoBoard: SCNNode)
    {
        //    let RedArmyRootNode = SCNNode()
        
        let player1 = Player(ludoBoard: ludoBoard, position: SCNVector3(-0.1,0,-0.1),
                             ArmyType: Constants.Army.green, number: 1, Scene: Constants.Scenes.gokuScene, NodeName: Constants.Nodes.goku, animatedNode: Constants.Nodes.gokuAnimationNode, childNamesToBeReplaced: Constants.Nodes.gokuChilds)
        
        //x: -0.07, y: 0, z: 0.067
        let player2 = Player(ludoBoard: ludoBoard, position : SCNVector3(-0.1,0,-0.07),ArmyType:  Constants.Army.green, number: 2, Scene: Constants.Scenes.gokuScene, NodeName: Constants.Nodes.goku, animatedNode: Constants.Nodes.gokuAnimationNode, childNamesToBeReplaced: Constants.Nodes.gokuChilds)
        
        //x: -0.1, y: 0, z: 0.067
        let player3 = Player(ludoBoard: ludoBoard, position : SCNVector3(-0.07,0,-0.07),ArmyType:  Constants.Army.green, number: 3, Scene: Constants.Scenes.gokuScene, NodeName: Constants.Nodes.goku, animatedNode: Constants.Nodes.gokuAnimationNode, childNamesToBeReplaced: Constants.Nodes.gokuChilds)
        
        //x: -0.1, y: 0, z: 0.1
        let player4 = Player(ludoBoard: ludoBoard, position : SCNVector3(-0.07,0,-0.1), ArmyType:  Constants.Army.green, number: 4, Scene: Constants.Scenes.gokuScene, NodeName: Constants.Nodes.goku, animatedNode: Constants.Nodes.gokuAnimationNode, childNamesToBeReplaced: Constants.Nodes.gokuChilds)
        greenArmy += [player1,player2,player3,player4]
        for greenPlayer in greenArmy
        {
            ludoBoard.addChildNode(greenPlayer.playerNode!)
            
        }
    }
    
    
}
