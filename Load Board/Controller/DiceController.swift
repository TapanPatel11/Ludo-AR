//
//  DiceController.swift
//  Load Board
//
//  Created by Tapan Patel on 10/09/21.
//  Copyright © 2021 Tapan Patel. All rights reserved.
//

import Foundation
import ARKit
import SceneKit
struct DiceController
{
    var rollDice:Bool
    var diceNumber:Int
    var dragonBallManager : DragonBallsController
    init(ludoBoard:SCNNode) {
        rollDice = true
        diceNumber = 1
        dragonBallManager = DragonBallsController(with: ludoBoard)
        
    }
    
    func nodeTappedIsDragonballs(tappedNode : String) -> Bool
    {
        print("node tapped is : \(tappedNode)")
        return Constants.allDragonBalls.contains(tappedNode) ?  true :  false
    }
    
    mutating func runDice(randomDiceNumber : Int)
    {
        if rollDice
        {
//            print("Dice Rolled : \(randomDiceNumber)")
            diceNumber = randomDiceNumber
            dragonBallManager.animateBall(nextBallIndex: diceNumber-1)
            //rollDice = gameLogicManager.checkIfToRollDice()
            
        }
        
        
    }
}
