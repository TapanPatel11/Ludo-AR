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
    var playersOut : [String:Bool]
    init ()
    {
        playersOut = [Constants.Army.red:false, Constants.Army.green:false]
        redArmy = [Player]()
        greenArmy = [Player]()
    }
    
    mutating   func createRedArmy(ludoBoard: SCNNode)
    {
        //    let RedArmyRootNode = SCNNode()
        
        let player1 = Player(ludoBoard: ludoBoard, position: SCNVector3(-0.1,0,0.1),
                             ArmyType: Constants.Army.red, number: 1, Scene: Constants.Scenes.KidBuuScene, NodeName: Constants.Nodes.KidBuu, animatedNode: Constants.Nodes.KidAnimatedNode, childNamesToBeReplaced: Constants.Nodes.kidChilds)
        //x: -0.07, y: 0, z: 0.067
        let player2 = Player(ludoBoard: ludoBoard, position : SCNVector3(-0.07,0,0.1),ArmyType: Constants.Army.red, number: 2, Scene: Constants.Scenes.KidBuuScene, NodeName: Constants.Nodes.KidBuu, animatedNode: Constants.Nodes.KidAnimatedNode, childNamesToBeReplaced: Constants.Nodes.kidChilds)
        
        //x: -0.1, y: 0, z: 0.067
        let player3 = Player(ludoBoard: ludoBoard, position : SCNVector3(-0.07,0,0.07),ArmyType: Constants.Army.red, number: 3, Scene: Constants.Scenes.KidBuuScene, NodeName: Constants.Nodes.KidBuu, animatedNode: Constants.Nodes.KidAnimatedNode, childNamesToBeReplaced: Constants.Nodes.kidChilds)
        
        //x: -0.1, y: 0, z: 0.1
        let player4 = Player(ludoBoard: ludoBoard, position : SCNVector3(-0.1,0,0.07), ArmyType: Constants.Army.red, number: 4, Scene: Constants.Scenes.KidBuuScene, NodeName: Constants.Nodes.KidBuu, animatedNode: Constants.Nodes.KidAnimatedNode, childNamesToBeReplaced: Constants.Nodes.kidChilds)
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
   
    func switchTurns()
    {
        switch GameController.whoseTurn {
        
        case .Green :
            GameController.whoseTurn = .Red
        case .Red:
            GameController.whoseTurn = .Green
        case .Dice:
            GameController.whoseTurn = .Dice
        }
    }
    mutating func updatePlayerRecord(player:Player, diceNumber : Int, lastTurn : GameController.Turn) -> Player
    {
        var tempPlayer = player
        if tempPlayer.isAtHome!
        {
            if diceNumber == 6
            {
                tempPlayer.isAtHome = false
                tempPlayer.stepsTaken! += 1
                getPlayerOutOfHome(player: tempPlayer, Army:lastTurn.rawValue)
            }
            else
            {
                // !6 - > anyPlayerOut = yes -> let user tap on its player -> user taps on a home player
                // but its not six so cant move
                // so tell user to choose its player again
                print("Cant move \(tempPlayer.playerNode!.name!), try another player")
                GameController.whoseTurn = lastTurn
                
            }
        }
        else
        {
            if diceNumber == 6
            {
                tempPlayer.stepsTaken! += diceNumber
                GameController.whoseTurn = .Dice
                
            }
            else
            {
                // !6 - > anyPlayerOut = yes -> let user tap on its player -> outside player
                // player is moved -> so change turns and roll dice
                tempPlayer.stepsTaken! += diceNumber
                GameController.whoseTurn = .Dice
                // switchTurns()
            }
        }
        return tempPlayer
    }
    
    func animatePlayer(player:Player, withKey key:String)
    {
        if player.hasAnimation!
        {
            print("Key : \(key)")
            //            player.playerNode?.animationPlayer(forKey: player.playerKeyDict[player.ArmyType!]!)?.play()
            player.playerNode?.animationPlayer(forKey: key)?.speed = 1.5
            player.playerNode?.animationPlayer(forKey: key)?.play()
            
        }
    }
    mutating func getPlayerOutOfHome(player:Player, Army : String)
    {
        if Army == Constants.Army.green
        {
            // animatePlayer(player: greenArmy[playerIndex])
            animatePlayer(player: player, withKey: player.playerKeyDict[Army]!)
            player.playerNode?.runAction(SCNAction.move(to: SCNVector3(-0.115,0.01,-0.02), duration: 1), completionHandler: {
                print("Animation : Player moved out of home ")
                player.playerNode?.animationPlayer(forKey: player.playerKeyDict[Army]!)?.stop()
                GameController.whoseTurn = .Dice
                
            })
            
        }
        if Army == Constants.Army.red
        {
            player.playerNode?.eulerAngles.y = .pi/2
            animatePlayer(player: player, withKey: Constants.AnimationKeys.kidBu[1])
            
            
            player.playerNode?.runAction(SCNAction.move(to: SCNVector3(-0.02,0.01,0.11), duration: 1.4), completionHandler: {
                            print("Animation : Player moved out of home ")
                            player.playerNode?.animationPlayer(forKey: Constants.AnimationKeys.kidBu[1])?.stop()
                player.playerNode?.eulerAngles.y += .pi/2

                            GameController.whoseTurn = .Dice
            
                        })
            
        }
    }
    
    //    mutating  func MoveThatPlayers(Army:String, playerName : String, diceNumber:Int)
    //    {
    //        //!!!!!!!!beaware of last turn here
    //        let playerIndex = playerName.last!.wholeNumberValue! - 1
    //        if Army == Constants.Army.green
    //        {
    //            animatePlayer(player: greenArmy[playerIndex], withKey: Constants.AnimationKeys.kidWalkAnimation)
    //        }
    //        if Army == Constants.Army.red
    //        {
    //
    //            if redArmy[playerIndex].isAtHome!//, diceNumber == 6
    //            {
    //                animatePlayer(player: redArmy[playerIndex], withKey: Constants.AnimationKeys.kidWalkAnimation)
    //
    //            }
    //        }
    //
    //    }
    
}
