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
    struct Scenes {
        static let ludoBoardScene = "art.scnassets/LudoBoard.scn"
        static let rootScene = "art.scnassets/RootScene.scn"
        static let DragonBallScene = "art.scnassets/Dragon.scn"
        static let KidBuuScene = "art.scnassets/KidBu.scn"
        static let gokuScene = "art.scnassets/goku.scn"
        
    }
    struct Nodes {
        static let LudoBoardNode = "LudoRootNode"
        static let DragonBallNode = "Dragon_Balls_0"
        static let detectedNode = "Detected node"
        static let goku = "GOKU_ROOT"
        static let gokuAnimationNode = "GOKU_ANIMATION"
        static let gokuChilds = "GOKU"
        static let KidBuu = "KidBuRootNode"
        static let KidAnimatedNode = "KidBuAnimationNode"
        static let KidJumpAnimatedNode = "KidBuAnimationNode1"
        static let kidChilds = "Bu_Bu_0"
    }
    
    struct AnimationKeys {
        
      static  let kidBu = ["unnamed animation #0","unnamed animation #1"]
      static  let goku = ["unnamed animation #0"]
       

    }
    struct AnimationNodes {
        static let kidBu = ["KidBuAnimationNode","KidBuAnimationNode1"]
        static let goku = ["GOKU_ANIMATION"]
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
