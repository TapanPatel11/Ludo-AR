//
//  Players.swift
//  Load Board
//
//  Created by Tapan Patel on 07/06/20.
//  Copyright © 2020 Tapan Patel. All rights reserved.
//

import Foundation
import SceneKit


class Players
{
    
    var isAtHome : Bool
    var sum:Int
    var stepsTaken :Int
    var currentPosition : SCNVector3
    var player : SCNNode
    
    init() {
        sum=0
        stepsTaken=0
        isAtHome=true
        currentPosition = SCNVector3(0,0,0)
        player = SCNNode()
    }
    func changeDirection(DiceNumber:Int, index:Int,positionToMoveTo:SCNVector3) -> SCNAction
    {
        var combinedAction:SCNAction
        switch index {
            
        case 5,6:
            let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(Int(-45).degreesToRadians), z: 0, duration: 0.5)
            let action = SCNAction.move(to: positionToMoveTo, duration: 0.5)//2
            combinedAction = SCNAction.group([rotation,action])
        case 10,11:
            
            let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(Int(45).degreesToRadians), z: 0, duration: 0.5)
            let action = SCNAction.move(to: positionToMoveTo, duration: 0.5)//2
            combinedAction = SCNAction.group([rotation,action])
        case 13,14:
            let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(Int(45).degreesToRadians), z: 0, duration: 0.5)
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
            combinedAction = SCNAction.move(to: positionToMoveTo, duration: 0.5)//2
        }
        
        return combinedAction
    }
    
    func move(dice:Int,stepsTaken:Int,stepDict:Dictionary<Int, Any>,animation:SCNAnimationPlayer,key:String,hasAnimations:Bool)
    {
        
        if stepsTaken <= 57
        {
            
            let previousStep = stepsTaken - dice
            if stepsTaken > 1
            {
                var actionSeqArray = [SCNAction()]  //1
                for index in (previousStep+1)...stepsTaken
                {
                    print("index : \(index)")
                    if let positionToMoveTo = stepLogDict[index] as? SCNVector3
                    {                        
                        let combinedAction = changeDirection(DiceNumber: dice, index: index, positionToMoveTo: positionToMoveTo)
                        
                        actionSeqArray += [combinedAction]
                    }
                }
                let actionSeq = SCNAction.sequence(actionSeqArray)
                player.runAction(actionSeq) {
                    self.player.animationPlayer(forKey: key)?.stop()
                    print("DONE MOVING")
                }
            }
            else
            {
                
                if let positionToMoveTo = stepLogDict[1] as? SCNVector3
                {
                    player.runAction(SCNAction.move(to: positionToMoveTo, duration: 0.5)) {
                        self.player.animationPlayer(forKey: key)?.stop()
                        
                        print("DONE MOVING")
                    }
                }
            }
        }
        else
        {
            print("Cant move, steps exceeds 57")
            self.stepsTaken -= dice
        }
    }
    
    func initialiseDict(ludoBoard:SCNNode, Army:String)
    {
        if Army == "RED"
        {
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.02,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.109), forKey: 1)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.02,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.091), forKey: 2)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.02,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.073), forKey: 3)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.02,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.055), forKey: 4)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.02,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.037), forKey: 5)
            //=============================================
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.04,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.019), forKey: 6)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.058,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.019), forKey: 7)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.076,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.019), forKey: 8)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.096,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.019), forKey: 9)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.113,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.019), forKey: 10)
            
            
            //------------------------------11-20-------------------------------\\
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.131,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.019), forKey: 11)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.131,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.001), forKey: 12)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.131,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 13)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.113,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 14)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.095,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 15)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.077,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 16)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.059,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 17)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.041,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 18)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.021,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.041), forKey: 19)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.021,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.059), forKey: 20)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.021,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.077), forKey: 21)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.021,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.095), forKey: 22)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.021,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.113), forKey: 23)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.021,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.131), forKey: 24)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.003,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.131), forKey: 25)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.131), forKey: 26)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.113), forKey: 27)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.095), forKey: 28)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.077), forKey: 29)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.059), forKey: 30)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.041), forKey: 31)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.037,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 32)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.056,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 33)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.074,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 34)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.092,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 35)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.11,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 36)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.128,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 37)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.128,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.002), forKey: 38)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.128,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.018), forKey: 39)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.11,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.018), forKey: 40)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.092,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.018), forKey: 41)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.074,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.018), forKey: 42)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.056,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.018), forKey: 43)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.038,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.018), forKey: 44)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.038), forKey: 45)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.056), forKey: 46 )//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.074), forKey: 47)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.092), forKey: 48)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.11), forKey: 49)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.128), forKey: 50)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.000,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.128), forKey: 51)//going inside
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.000,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.11), forKey: 52)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.000,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.092), forKey: 53)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.000,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.074), forKey: 54)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.000,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.056), forKey: 55)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.000,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.038), forKey: 56)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.000,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.002), forKey: 57)
        }
        else if Army == "GREEN"
        {
            //Green start from here
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.113,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 1)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.095,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 2)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.077,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 3)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.059,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 4)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.041,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 5)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.021,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.041), forKey: 6)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.021,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.059), forKey: 7)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.021,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.077), forKey: 8)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.021,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.095), forKey: 9)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.021,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.113), forKey: 10)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.021,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.131), forKey: 11)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.003,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.131), forKey: 12)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.131), forKey: 13)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.113), forKey: 14)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.095), forKey: 15)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.077), forKey: 16)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.059), forKey: 17)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.041), forKey: 18)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.037,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 19)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.056,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 20)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.074,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 21)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.092,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 22)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.11,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 23)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.128,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.02), forKey: 24)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.128,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.002), forKey: 25)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.128,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.018), forKey: 26)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.11,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.018), forKey: 27)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.092,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.018), forKey: 28)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.074,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.018), forKey: 29)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.056,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.018), forKey: 30)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.038,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.018), forKey: 31)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.038), forKey: 32)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.056), forKey: 33 )//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.074), forKey: 34)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.092), forKey: 35)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.11), forKey: 36)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.018,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.128), forKey: 37)//
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x+0.000,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.128), forKey: 38)
            
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.02,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.128), forKey: 39)
            
            
            
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.02,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.109), forKey: 40)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.02,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.091), forKey: 41)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.02,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.073), forKey: 42)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.02,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.055), forKey: 43)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.02,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.037), forKey: 44)
            //=============================================
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.04,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.019), forKey: 45)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.058,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.019), forKey: 46)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.076,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.019), forKey: 47)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.096,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.019), forKey: 48)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.113,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.019), forKey: 49)
            
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.131,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z+0.019), forKey: 50)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.131,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.001), forKey: 51)
            
            /// now going inside
            
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.113,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.001), forKey: 52)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.095,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.001), forKey: 53)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.077,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.001), forKey: 54)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.059,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.001), forKey: 55)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.041,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.001), forKey: 56)
            
            stepLogDict.updateValue(SCNVector3(
                ludoBoard.position.x-0.023,
                ludoBoard.position.y + 0.01,
                ludoBoard.position.z-0.001), forKey: 57)
        }
        
    }
    
    
    
    var stepLogDict = Dictionary<Int, Any>()
    
}


