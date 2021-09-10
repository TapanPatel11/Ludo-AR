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
     var rollDice = true
    var diceNumber = 1
    var dragonBallManager : DragonBallsController
    
    init(ludoBoard:SCNNode) {
        dragonBallManager = DragonBallsController(with: ludoBoard)
    }
    
    func nodeTappedIsDragonballs(tappedNode : String) -> Bool
    {
        print("node tapped is : \(tappedNode)")
       return Constants.allDragonBalls.contains(tappedNode) ?  true :  false
    }
}
