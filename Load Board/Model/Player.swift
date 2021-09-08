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
    var isAtHome : Bool
    var sum:Int
    var stepsTaken:Int
    var currentPosition : SCNVector3
    var ArmyType : String
    static var isMyTurn:Bool = false

}
