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
                             ArmyType: Constants.Army.red, number: 1, Scene: Constants.Scenes.allPlayers, NodeName: Constants.Nodes.KidBuu)
        //x: -0.07, y: 0, z: 0.067
        let player2 = Player(ludoBoard: ludoBoard, position : SCNVector3(-0.07,0,0.1),ArmyType: Constants.Army.red, number: 2, Scene: Constants.Scenes.allPlayers, NodeName: Constants.Nodes.Hit)
        
        //x: -0.1, y: 0, z: 0.067
        let player3 = Player(ludoBoard: ludoBoard, position : SCNVector3(-0.07,0,0.07),ArmyType: Constants.Army.red, number: 3, Scene: Constants.Scenes.allPlayers, NodeName: Constants.Nodes.Jiren)
        
        //x: -0.1, y: 0, z: 0.1
        let player4 = Player(ludoBoard: ludoBoard, position : SCNVector3(-0.1,0,0.07), ArmyType: Constants.Army.red, number: 4, Scene: Constants.Scenes.allPlayers, NodeName: Constants.Nodes.Videl)
        redArmy += [player1,player2,player3,player4]
        for redPlayer in redArmy
        {
            ludoBoard.addChildNode(redPlayer.playerNode!)
            
        }
    }
    
    mutating   func createGreenArmy(ludoBoard: SCNNode)
    {        
        let player1 = Player(ludoBoard: ludoBoard, position: SCNVector3(-0.1,0,-0.1),
                             ArmyType: Constants.Army.green, number: 1, Scene: Constants.Scenes.allPlayers, NodeName: Constants.Nodes.Kefla)
        
        //x: -0.07, y: 0, z: 0.067
        let player2 = Player(ludoBoard: ludoBoard, position : SCNVector3(-0.1,0,-0.07),ArmyType:  Constants.Army.green, number: 2, Scene: Constants.Scenes.allPlayers, NodeName: Constants.Nodes.Vegito)
        
        //x: -0.1, y: 0, z: 0.067
        let player3 = Player(ludoBoard: ludoBoard, position : SCNVector3(-0.07,0,-0.07),ArmyType:  Constants.Army.green, number: 3, Scene: Constants.Scenes.allPlayers, NodeName: Constants.Nodes.Bulma)
        
        //x: -0.1, y: 0, z: 0.1
        let player4 = Player(ludoBoard: ludoBoard, position : SCNVector3(-0.07,0,-0.1), ArmyType:  Constants.Army.green, number: 4, Scene: Constants.Scenes.allPlayers, NodeName: Constants.Nodes.Vegeta)
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
                MoveThatPlayers(player: tempPlayer, diceNumber:diceNumber)
                GameController.whoseTurn = .Dice
                
            }
            else
            {
                // !6 - > anyPlayerOut = yes -> let user tap on its player -> outside player
                // player is moved -> so change turns and roll dice
                tempPlayer.stepsTaken! += diceNumber
                MoveThatPlayers(player: tempPlayer, diceNumber:diceNumber)
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
            //player.playerNode?.animationPlayer(forKey: key)?.speed = 1.5
            player.playerNode?.animationPlayer(forKey: key)?.play()
            
        }
    }
    mutating func getPlayerOutOfHome(player:Player, Army : String)
    {
        if Army == Constants.Army.green
        {
            player.playerNode?.eulerAngles.y = 0
            animatePlayer(player: player, withKey: Constants.AnimationKeys.commonAnimations[1])
            
            
            player.playerNode?.runAction(SCNAction.move(to: SCNVector3(-0.11,0.01,-0.02), duration: 1.3), completionHandler: {
                print("Animation : Player moved out of home ")
                player.playerNode?.eulerAngles.y = .pi/2
                
                GameController.whoseTurn = .Dice
                
            })
            
        }
        if Army == Constants.Army.red
        {
            player.playerNode?.eulerAngles.y = .pi/2
            animatePlayer(player: player, withKey: Constants.AnimationKeys.commonAnimations[1])
            
            
            player.playerNode?.runAction(SCNAction.move(to: SCNVector3(-0.02,0.01,0.11), duration: 1.3), completionHandler: {
                print("Animation : Player moved out of home ")
                //                player.playerNode?.animationPlayer(forKey: Constants.AnimationKeys.commonAnimations[1])?.stop()
                player.playerNode?.eulerAngles.y += .pi/2
                
                GameController.whoseTurn = .Dice
                
            })
            
        }
    }
    
    
    func changeDirection(DiceNumber:Int, index:Int,positionToMoveTo:SCNVector3) -> SCNAction
    {
        var combinedAction:SCNAction
        switch index {
        
        case 5,6:
            let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(Int(45).degreesToRadians), z: 0, duration: 0.5)
            let action = SCNAction.move(to: positionToMoveTo, duration: 0.5)//2
            combinedAction = SCNAction.group([rotation,action])
        case 10,11:
            
            let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(Int(-45).degreesToRadians), z: 0, duration: 0.5)
            let action = SCNAction.move(to: positionToMoveTo, duration: 0.5)//2
            combinedAction = SCNAction.group([rotation,action])
        case 13,14:
            let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(Int(-45).degreesToRadians), z: 0, duration: 0.5)
            let action = SCNAction.move(to: positionToMoveTo, duration: 0.5)//2
            combinedAction = SCNAction.group([rotation,action])
        case 18,19:
            let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(Int(-45).degreesToRadians), z: 0, duration: 0.5)
            let action = SCNAction.move(to: positionToMoveTo, duration: 0.5)//2
            combinedAction = SCNAction.group([rotation,action])
        case 23,24:
            let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(Int(45).degreesToRadians), z: 0, duration: 0.5)
            let action = SCNAction.move(to: positionToMoveTo, duration: 0.5)//2
            combinedAction = SCNAction.group([rotation,action])
        case 26,27:
            let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(Int(45).degreesToRadians), z: 0, duration: 0.5)
            let action = SCNAction.move(to: positionToMoveTo, duration: 0.5)//2
            combinedAction = SCNAction.group([rotation,action])
        case 31,32:
            let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(Int(-45).degreesToRadians), z: 0, duration: 0.5)
            let action = SCNAction.move(to: positionToMoveTo, duration: 0.5)//2
            combinedAction = SCNAction.group([rotation,action])
        case 36,37:
            let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(Int(45).degreesToRadians), z: 0, duration: 0.5)
            let action = SCNAction.move(to: positionToMoveTo, duration: 0.5)//2
            combinedAction = SCNAction.group([rotation,action])
        case 39,40:
            let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(Int(45).degreesToRadians), z: 0, duration: 0.5)
            let action = SCNAction.move(to: positionToMoveTo, duration: 0.5)//2
            combinedAction = SCNAction.group([rotation,action])
        case 44,45:
            let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(Int(-45).degreesToRadians), z: 0, duration: 0.5)
            let action = SCNAction.move(to: positionToMoveTo, duration: 0.5)//2
            combinedAction = SCNAction.group([rotation,action])
            
        case 49,50:
            let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(Int(45).degreesToRadians), z: 0, duration: 0.5)
            let action = SCNAction.move(to: positionToMoveTo, duration: 0.5)//2
            combinedAction = SCNAction.group([rotation,action])
        case 51,52:
            let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(Int(45).degreesToRadians), z: 0, duration: 0.5)
            let action = SCNAction.move(to: positionToMoveTo, duration: 0.5)//2
            combinedAction = SCNAction.group([rotation,action])
            
        default:
            combinedAction = SCNAction.move(to: positionToMoveTo, duration: 1)//2
        }
        
        return combinedAction
    }
    
    
    mutating func checkIfToTakeTurn(playerSteps: Int) -> Int
    {
        for turn in Constants.TakeTurns.allTurns
        {
            if turn.contains(playerSteps)
            {
                return turn.first!
            }
        }
        return 0
    }
    
    func changeDirection(turnPosition : SCNVector3, lastStepPosition : SCNVector3) -> SCNAction
    {
        var   combinedAction = SCNAction()
        var moveTillTurn = SCNAction()
        var rotation = SCNAction()
        var moveAction = SCNAction()
        if turnPosition.x == lastStepPosition.x , turnPosition.y == lastStepPosition.y, turnPosition.z == lastStepPosition.z
        {
             moveTillTurn = SCNAction.move(to: turnPosition, duration: 1.166)

        }
        else
        {
            rotation = SCNAction.rotateBy(x: 0, y: CGFloat(Int(-45).degreesToRadians), z: 0, duration: 0.5)
            moveAction = SCNAction.move(to: lastStepPosition, duration: 1.166)//2
        }
       
        combinedAction = SCNAction.group([moveTillTurn,rotation,moveAction])
        return combinedAction
    }
    
    mutating  func MoveThatPlayers(player : Player, diceNumber:Int)
    {
        
      //player idle animation stop
        player.playerNode!.animationPlayer(forKey: Constants.AnimationKeys.commonAnimations[2])!.stop()
            
            let previousStep = player.stepsTaken! - diceNumber
            var actionSeqArray = [SCNAction()]  //1
            for index in (previousStep+1)...player.stepsTaken!
            {
                //print("index : \(index)")
                if let positionToMoveTo = player.stepLogDict[index]
                {
                    let combinedAction = changeDirection(DiceNumber: diceNumber, index: index, positionToMoveTo: positionToMoveTo)
                    
                    actionSeqArray += [combinedAction]
                }
            }
            let actionSeq = SCNAction.sequence(actionSeqArray)
            animatePlayer(player: player, withKey: Constants.AnimationKeys.commonAnimations[0])
            player.playerNode!.runAction(actionSeq) { [self] in
                player.playerNode!.animationPlayer(forKey: Constants.AnimationKeys.commonAnimations[0])!.stop()
               
                //player idle animation start
                 self.animatePlayer(player: player, withKey: Constants.AnimationKeys.commonAnimations[2])
                print("DONE MOVING")
            }
            
                    
    }
    
}
