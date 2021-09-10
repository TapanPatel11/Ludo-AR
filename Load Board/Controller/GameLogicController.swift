//
//  GameLogicController.swift
//  Load Board
//
//  Created by Tapan Patel on 10/09/21.
//  Copyright © 2021 Tapan Patel. All rights reserved.
//

import Foundation
import ARKit
import SceneKit
struct GameLogicController
{
    //    static func checkTurn(diceNumber : Int)
    //    {
    //        if diceNumber == 6
    //        {
    //            GameController.whoseTurn = .Green
    //            if PlayerController.playersOut[Constants.Army.green]!
    //            {
    //
    //            }
    //        }
    //    }
    var gameManager : GameController
    init(node:SCNNode) {
        gameManager = GameController(mainNode: node)
        lastTurn = .Red
    }
    var lastTurn : GameController.Turn
    
    mutating func checkIfToRollDice()
    {
//        print("in logic Controller : \(gameManager.diceManager.diceNumber)")
        gameManager.diceManager.diceNumber = 6
        if gameManager.diceManager.diceNumber == 6
        {
            print("Its 6...")
            if checkifAnyPlayersOut(ofArmy: lastTurn.rawValue)
            {
                // let user tap any of its player
                GameController.whoseTurn = lastTurn
                print("Players Out : \(lastTurn.rawValue), please tap on your player!")
                
            }
            else
            {
                print("No One : \(lastTurn.rawValue), first player moved !")
                handlePlayerMovement(armyType: lastTurn, playerIndex: 0)
                //remove first Player automatically
            }
        }
        else
        {
            print("Its \(gameManager.diceManager.diceNumber)")
            if checkifAnyPlayersOut(ofArmy: lastTurn.rawValue)
            {
                //!6 - > anyPlayerOut = yes -> let user tap on its player
                print("Players Out : \(lastTurn.rawValue), please tap on your player!")
                GameController.whoseTurn = lastTurn
                
            }
            else //!6 -> noPlayerOut -> change turn and roll dice
            {
                switchTurns()
                print("No One : \(lastTurn.rawValue), your turn, roll the dice !")
                GameController.whoseTurn = .Dice
            }
        }
    }
    mutating func handlePlayerMovement( armyType:GameController.Turn, playerIndex : Int)
    {
        switch armyType {
        
        case .Red:
            if checkifAnyPlayersOut(ofArmy: armyType.rawValue) // Plyr out
            {
                
                gameManager.playerManager.redArmy[playerIndex] = gameManager.playerManager.updatePlayerRecord(player: gameManager.playerManager.redArmy[playerIndex], diceNumber: gameManager.diceManager.diceNumber, lastTurn: lastTurn)
                print("\(gameManager.playerManager.redArmy[playerIndex].playerNode!.name!) moved \((gameManager.playerManager.redArmy[playerIndex].stepsTaken)!) steps")
               switchTurns()

            }
            else //NOplyr out
            {
                                
                gameManager.playerManager.redArmy[playerIndex] = gameManager.playerManager.updatePlayerRecord(player: gameManager.playerManager.redArmy[playerIndex], diceNumber: gameManager.diceManager.diceNumber, lastTurn: lastTurn)
                gameManager.playerManager.playersOut[armyType.rawValue] = true
                print("\(gameManager.playerManager.redArmy[playerIndex].playerNode!.name!) moved \(gameManager.playerManager.redArmy[playerIndex].stepsTaken!) steps")
                switchTurns()
            }
        case .Green:
            if checkifAnyPlayersOut(ofArmy: armyType.rawValue) // Plyr out
            {
                
                gameManager.playerManager.greenArmy[playerIndex] = gameManager.playerManager.updatePlayerRecord(player: gameManager.playerManager.greenArmy[playerIndex], diceNumber: gameManager.diceManager.diceNumber, lastTurn: lastTurn)
                print("\(gameManager.playerManager.greenArmy[playerIndex].playerNode!.name!) moved \(gameManager.playerManager.greenArmy[playerIndex].stepsTaken!) steps")
               switchTurns()

            }
            else //NOplyr out
            {
                                
                gameManager.playerManager.greenArmy[playerIndex] = gameManager.playerManager.updatePlayerRecord(player: gameManager.playerManager.greenArmy[playerIndex], diceNumber: gameManager.diceManager.diceNumber, lastTurn: lastTurn)
                gameManager.playerManager.playersOut[armyType.rawValue] = true
                print("\(String(describing: gameManager.playerManager.greenArmy[playerIndex].playerNode!.name)) moved \(gameManager.playerManager.greenArmy[playerIndex].stepsTaken!) steps")
                switchTurns()
            }
            
        case .Dice:
            print("Do nothin")
        }
    }
    
    mutating func switchTurns()
    {
        if GameController.whoseTurn == .Dice
        {
            if gameManager.diceManager.diceNumber == 6
            {
                print("Turn remains same")
                switch lastTurn {
                case .Green:
                    lastTurn = .Green
                case .Red :
                    lastTurn = .Red
                default:
                    print("Defaulting last turn to DICE!!!")
                    lastTurn = .Dice
                }
            }
            else
            {
                print("Turn switched")
                switch lastTurn {
                case .Green:
                    lastTurn = .Red
                case .Red :
                    lastTurn = .Green
                default:
                    print("Defaulting last turn to DICE!!!")
                    lastTurn = .Dice
                }
            }
        }
        else
        {
            print("Cant switch, waitin for player to tap")
        }
    }
    func checkifAnyPlayersOut(ofArmy army:String) -> Bool
    {
        return gameManager.playerManager.playersOut[army]! ? true : false
    }
    
}
