//
//  Constants.swift
//  Load Board
//
//  Created by Tapan Patel on 08/09/21.
//  Copyright © 2021 Tapan Patel. All rights reserved.
//

import Foundation

struct Constants
{
    
    struct TakeTurns
    {
        static let firstTurn = 5
        static let secondTurn = 11
        static let thirdTurn = 13
        static let fourthTurn = 18
        static let fifthTurn = 24
        
        
        static let allTurns  = [5...10,11...12,13...17,18...23]
        
    }
    struct Scenes {
        static let ludoBoardScene = "art.scnassets/LudoBoard.scn"
        static let rootScene = "art.scnassets/RootScene.scn"
        static let DragonBallScene = "art.scnassets/Dragon.scn"
        static let KidBuuScene = "art.scnassets/KidBu.scn"
        static let gokuScene = "art.scnassets/BULMA.scn"// goku
        static let allPlayers = "art.scnassets/ALL_Players.scn"
        static let JIREN = "art.scnassets/JIREN.scn"

        
    }
    struct Nodes {
        static let LudoBoardNode = "LudoRootNode"
        static let DragonBallNode = "Dragon_Balls_0"
        static let detectedNode = "Detected node"
        static let goku = "GOKU_ROOT"
        static let gokuAnimationNode = "GOKU_ANIMATION"
        static let gokuChilds = "GOKU"
        
        static let KidBuu = "KIDBUU"
        static let Videl = "VIDEL"
        static let Jiren = "JIREN"
        static let Hit = "HIT"
        
        static let Kefla = "KEFLA"
        static let Bulma = "BULMA"
        static let Vegeta = "VEGETA"
        static let Vegito = "VEGITO"
        
        static let KidAnimatedNode = "KidBuAnimationNode"
        static let KidJumpAnimatedNode = "KidBuAnimationNode1"
        static let kidChilds = "Bu_Bu_0"
        
        
    }
    
    struct AnimationKeys {
        
      static  let kidBu = ["unnamed animation #0","unnamed animation #1"]
      static  let goku = ["unnamed animation #0"]
    static let commonAnimations = ["StandardWalk","FrontFlip","Idle"]
       

    }
    struct AnimationNodes {
        static let kidBu = ["KidBuAnimationNode","KidBuAnimationNode1"]
        static let goku = ["GOKU_ANIMATION"]
        static let commonNodes = ["StandardWalk","FrontFlip","Idle"]
    }
    static let allDragonBalls = ["Dragon_Balls_07",
                          "Dragon_Balls_01",
                          "Dragon_Balls_02",
                          "Dragon_Balls_03",
                          "Dragon_Balls_04",
                          "Dragon_Balls_05",
                          "Dragon_Balls_06"]
    
    struct Army {
        static let red = "RedArmy"
        static let green = "GreenArmy"
    }
}
