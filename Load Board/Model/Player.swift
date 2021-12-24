//
//  Player.swift
//  Load Board
//
//  Created by Tapan Patel on 07/09/21.
//  Copyright © 2021 Tapan Patel. All rights reserved.
//

import Foundation
import SceneKit

struct Player
{
    var playerNode : SCNNode?
    var playerNumber : Int?
    var isAtHome : Bool?
    var stepsTaken:Int?
    var ArmyType : String?
    var hasAnimation:Bool?
    var playerKeyDict = Dictionary<String, String>()
    var playerAnimationDict = Dictionary<String, SCNAnimationPlayer>()
    var stepLogDict = Dictionary<Int, SCNVector3 >()
    mutating func fetchAnimationSettings(position:SCNVector3, ArmyType:String, number:Int,Scene:String,NodeName: String) -> (SCNNode?,[String]?,[SCNAnimationPlayer]?)?
    {
        var animationKey :[String]?
        var animationPlayer :[SCNAnimationPlayer]?
        var node:SCNNode?
        
        if let animatedScene = SCNScene(named: Scene)
        {
            
            var newAnimationNodes = Constants.AnimationNodes.commonNodes
            
            
            if let nodeToAnimate = animatedScene.rootNode.childNode(withName: NodeName, recursively: false)
            {
                
                print("*****fetching keys for \(nodeToAnimate.name!)******")
                for newAnimationNode in newAnimationNodes
                {
                    if let animationNode = animatedScene.rootNode.childNode(withName: "\(NodeName)\(newAnimationNode)", recursively: true)
                    {
                        //fetch animation key
                        print("Animation node name : \(animationNode.name!)")
                        
                        if let key = animationNode.animationKeys.first
                        {
                            animationKey?.append(key)
                            print("\(ArmyType)->🔑:\(key) INITIALISED!")
                            if let player = animationNode.animationPlayer(forKey: key)
                            {
                                
                                animationPlayer?.append(player)
                                nodeToAnimate.addAnimationPlayer(player, forKey: key)
                                // nodeToAnimate.animationPlayer(forKey: key)!.stop()
                                // print("Stoping \(key)")
                            }
                        }
                        
                        
                    }
                }
                
                
                //                rename all childs except animation node
                newAnimationNodes = newAnimationNodes.map { (string)  in
                    "\(NodeName)\(string)"
                }
                
                for name in newAnimationNodes
                {
                    print(name)
                }
                nodeToAnimate.enumerateChildNodes { (child, nil) in
                    if child.name != nil, !newAnimationNodes.contains("\(child.name!)")
                        {
//                            print("\(child.name!) -> ")
                            child.name = "\(ArmyType)\(number)"
//                            print("\(child.name!)  ")
//                        else
//                        {
//                            print("\(child.name!) not renamed")
//                        }
                    }
                    
                }
                
                nodeToAnimate.position = position
                nodeToAnimate.position.y += 0.01
                nodeToAnimate.name = "\(ArmyType)\(number)"
                node = nodeToAnimate
            }
        }
        return (node,animationKey,animationPlayer)
        
    }
    mutating func stopAllAnimations()
    {
        for key in Constants.AnimationNodes.commonNodes
        {
            playerNode!.animationPlayer(forKey: key)?.stop()
        }
    }
    
    init(ludoBoard:SCNNode, position:SCNVector3, ArmyType:String, number:Int,Scene:String, NodeName: String) {
        playerNode = SCNNode()
        
        if  let animationSetting = fetchAnimationSettings(position: position, ArmyType: ArmyType, number: number, Scene: Scene, NodeName: NodeName)
        {
            if let animatedNode = animationSetting.0
            {
                
                playerNode  = animatedNode

                initialiseDict(ludoBoard: ludoBoard,ArmyType: ArmyType)
                playerNumber = number
                isAtHome = true
                stepsTaken = 0
                self.ArmyType = ArmyType
                hasAnimation = true
                stopAllAnimations()
                print("\(ArmyType)#\(playerNumber!) successfully initialized")
            }
        }
    }
    mutating  func initialiseDict(ludoBoard:SCNNode, ArmyType:String)
    {
        if ArmyType == Constants.Army.red
        {
            stepLogDict.updateValue(SCNVector3(-0.02,0.01,0.11), forKey: 1) // 0.018
            
            stepLogDict.updateValue(SCNVector3(-0.02,0.01,0.095), forKey: 2)
            
            stepLogDict.updateValue(SCNVector3(-0.02,0.01,0.077), forKey: 3)
            
            stepLogDict.updateValue(SCNVector3(-0.02,0.01,0.059), forKey: 4)
            //---------------------first turn--------------------------------
            stepLogDict.updateValue(SCNVector3(-0.02,0.01,0.041), forKey: 5)
            stepLogDict.updateValue(SCNVector3(-0.034,0.01,0.015), forKey: 6)
            stepLogDict.updateValue(SCNVector3(-0.052,0.01,0.015), forKey: 7)
            stepLogDict.updateValue(SCNVector3(-0.070,0.01,0.015), forKey: 8)
            stepLogDict.updateValue(SCNVector3(-0.088,0.01,0.015), forKey: 9)
            stepLogDict.updateValue(SCNVector3(-0.106,0.01,0.015), forKey: 10)
            //------------------------------11-20-------------------------------\\
            stepLogDict.updateValue(SCNVector3(-0.124,0.01,0.015), forKey: 11)
            
            stepLogDict.updateValue(SCNVector3(-0.124,0.01,0.015), forKey: 12)
            
            stepLogDict.updateValue(SCNVector3(-0.124,0.01,0.015), forKey: 13)
            
            stepLogDict.updateValue(SCNVector3(-0.124,0.01,0.015), forKey: 14)
            
            stepLogDict.updateValue(SCNVector3(-0.124,0.01,0.015), forKey: 15)
            
            stepLogDict.updateValue(SCNVector3(-0.124,0.01,0.015), forKey: 16)
            
            stepLogDict.updateValue(SCNVector3(-0.124,0.01,0.015), forKey: 17)
            
            stepLogDict.updateValue(SCNVector3(-0.124,0.01,0.015), forKey: 18)
            
            stepLogDict.updateValue(SCNVector3(-0.124,0.01,0.015), forKey: 19)
            
            stepLogDict.updateValue(SCNVector3(-0.124,0.01,0.015), forKey: 20)
            
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
        else if ArmyType == Constants.Army.green
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
    
    
    
    
}
