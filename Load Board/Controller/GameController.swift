//
//  GameController.swift
//  Load Board
//
//  Created by Tapan Patel on 10/09/21.
//  Copyright © 2021 Tapan Patel. All rights reserved.
//

import Foundation
import ARKit
import SceneKit
struct GameController
{
    static var isGameBoardLoaded:Bool = false
    var ludoBoardManager:LudoBoardController
    var diceManager:DiceController
    var playerManager:PlayerController
    static var whoseTurn : Turn = Turn.Dice
    enum Turn : String
    {
        case Red = "RedArmy"
        case Green = "GreenArmy"
        case Dice = "Dice"
    }
    init(mainNode:SCNNode) {
//        whoseTurn = Turn.Dice
        ludoBoardManager = LudoBoardController()
        ludoBoardManager.initializeLudoBoard(withNode: mainNode)        
        diceManager = DiceController(ludoBoard: ludoBoardManager.ludoBoard)
        playerManager = PlayerController()
        playerManager.createRedArmy(ludoBoard: ludoBoardManager.ludoBoard)
        playerManager.createGreenArmy(ludoBoard: ludoBoardManager.ludoBoard)
    }
    mutating  func movePlayer(army : String, playerName : String) //RedArmy , RedArmy1, 2
    {
        playerManager.MoveThatPlayers(Army: army, playerName: playerName, diceNumber: diceManager.diceNumber)
    }
    
   mutating func removePlayerFromHome(army : String, playerName : String)
    {
        
    }
}
