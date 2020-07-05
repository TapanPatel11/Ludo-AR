//
//  ViewController.swift
//  Load Board
//
//  Created by Tapan Patel on 30/05/20.
//  Copyright © 2020 Tapan Patel. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate ,SCNAnimationProtocol{
    
    @IBOutlet var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    var ludoBoard = SCNNode()
    var ludoScene = SCNScene()
    var DiceNumber = 0
    var redPlayerArmy = [Players()]
    var greenPlayerArmy = [Players()]
    var whoseTurnItIs = Turn.Green
    var Dragonballs = [SCNNode()]
    var previousBall = 3
    var animationNode = SCNAnimationPlayer()
    var NodeKeyDict = Dictionary<String, String>()
    var NodeanimationDict = Dictionary<String, SCNAnimationPlayer>()
    var MainNode = SCNNode()
    //CANT MOVE EXCEED 57 => DO SOMETHING
    var PlayersOut : [String:Bool] = ["RED":false,"GREEN":false]
    var rollDice = true
    var boardLoaded = false
    var MainNodePosition = SCNVector3()

    
    enum Turn : String
    {
        case RED = "RED"
        case Green = "GREEN"
    }
    
    
    
    //------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        // let animation = animationFromSceneNamed(path: "art.scnassets/animation.dae")
        // myNode.addAnimation(animation, forKey: "anim")
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        sceneView.debugOptions = [.showFeaturePoints,.showFeaturePoints]
        configuration.planeDetection = .horizontal
        // Run the view's session
        sceneView.session.run(configuration)
        let scene = SCNScene(named: "art.scnassets/RootScene.scn")!
        // Set the scene to the view
        sceneView.autoenablesDefaultLighting = true
        
        //Load all models
        DispatchQueue.main.async {
            guard let ludoSceneTemp = SCNScene(named: "art.scnassets/LudoBoard.scn") else {return}// do this somewhere else
            self.ludoScene =  ludoSceneTemp
            
            guard let boardNode = self.ludoScene.rootNode.childNode(withName: "LudoBoard", recursively: true) else {return}
            self.ludoBoard = boardNode
            
//            guard let diceNodeTemp = self.ludoScene.rootNode.childNode(withName: "Dice", recursively: true) else {return}
//            self.diceNode = diceNodeTemp
            print("In VIEW DID LOAD")
            guard let DBScene = SCNScene(named: "art.scnassets/Dragon.scn") else {return}
            for i in 1...6
            {
                let ballNode = DBScene.rootNode.childNode(withName: "Dragon_Balls_0\(i)", recursively: false)!
                
                   // print("\(ballNode.name) added to arrays")
                    ballNode.position = self.ludoBoard.position
                   ballNode.position.y = self.ludoBoard.position.y + 0.1
                   ballNode.isHidden = true
                   self.Dragonballs += [ballNode]
               
                
            }
            self.Dragonballs.remove(at: 0)
            
            
            
        }
        let pinchGesture = UIPanGestureRecognizer(target: self, action: #selector(scalePiece))
        sceneView.addGestureRecognizer(pinchGesture)
        sceneView.scene = scene
    }
    
    
    
    
    
    
    func createAnimatedPlayer(ludoBoard:SCNNode, position:SCNVector3, ArmyType:String, number:Int,Scene:String, NodeName: String,animatedNode:String,childNamesToBeReplaced:String) -> Players?
    {
        let classPlayer = Players()
        let animatedScene = SCNScene(named: "art.scnassets/\(Scene).scn")
        if let nodeToAnimate = animatedScene!.rootNode.childNode(withName: NodeName, recursively: false)
        {
            if let animationNode = animatedScene!.rootNode.childNode(withName: animatedNode, recursively: true)
            {
                let key = animationNode.animationKeys.first
                NodeKeyDict.updateValue(key!, forKey: ArmyType)
                print("🔑 INITIALISED!")
                if let animation = animationNode.animationPlayer(forKey: key!)
                {
                    //self.animationNode = animation
                    NodeanimationDict.updateValue(animation, forKey: ArmyType)
                    nodeToAnimate.addAnimationPlayer(animation, forKey: key)
                    nodeToAnimate.animationPlayer(forKey: key!)?.stop()
                }
            }
            nodeToAnimate.enumerateChildNodes { (child, nil) in
                if child.name == childNamesToBeReplaced
                {
                    //print("\(child.name!) is changed to ")
                    child.name = "\(ArmyType)\(number)"
                    //print("\(child.name!)")
                }
            }
            nodeToAnimate.position = position
            nodeToAnimate.position.y += 0.01
            nodeToAnimate.name = "\(ArmyType)\(number)"
            classPlayer.player  = nodeToAnimate
            classPlayer.initialiseDict(ludoBoard: ludoBoard,Army: ArmyType)
            
        }
        return classPlayer
    }
    
    
    
    func initializeGREENArmy(node:SCNNode)
    {
        //-0.07,0,0.1
        guard let player1 = createAnimatedPlayer(ludoBoard: ludoBoard, position: SCNVector3(
            self.ludoBoard.position.x-0.1,
            self.ludoBoard.position.y,
            self.ludoBoard.position.z-0.07), ArmyType: "GREEN", number: 1, Scene: "goku", NodeName: "GOKU_ROOT", animatedNode: "GOKU_ANIMATION", childNamesToBeReplaced: "GOKU") else {return}
        
        guard let player2 = createAnimatedPlayer(ludoBoard: ludoBoard, position : SCNVector3(
            self.ludoBoard.position.x-0.07,
            self.ludoBoard.position.y,
            self.ludoBoard.position.z-0.07), ArmyType: "GREEN", number: 2, Scene: "goku", NodeName: "GOKU_ROOT", animatedNode: "GOKU_ANIMATION", childNamesToBeReplaced: "GOKU") else {return}
        //x: -0.1, y: 0, z: 0.067
        guard let player3 = createAnimatedPlayer(ludoBoard: ludoBoard, position : SCNVector3(
            self.ludoBoard.position.x-0.07,
            self.ludoBoard.position.y,
            self.ludoBoard.position.z-0.1),ArmyType: "GREEN", number: 3, Scene: "goku", NodeName: "GOKU_ROOT", animatedNode: "GOKU_ANIMATION", childNamesToBeReplaced: "GOKU") else {return}
        //x: -0.1, y: 0, z: 0.1
        guard let player4 = createAnimatedPlayer(ludoBoard: ludoBoard, position : SCNVector3(
            self.ludoBoard.position.x-0.1,
            self.ludoBoard.position.y,
            self.ludoBoard.position.z-0.1), ArmyType: "GREEN", number: 4, Scene: "goku", NodeName: "GOKU_ROOT", animatedNode: "GOKU_ANIMATION", childNamesToBeReplaced: "GOKU") else {return}
        
        greenPlayerArmy += [player1,player2,player3,player4]
        
        greenPlayerArmy.remove(at: 0)
        
        for player in greenPlayerArmy
        {
            node.addChildNode(player.player)
        }
        
    }
    
    
    
    func initializeREDArmy(node:SCNNode) //armyArray /position // name
    {
        //-0.07,0,0.1
        guard let player1 = createAnimatedPlayer(ludoBoard: ludoBoard, position: SCNVector3(
            self.ludoBoard.position.x-0.07,
            self.ludoBoard.position.y,
            self.ludoBoard.position.z+0.1), ArmyType: "RED", number: 1, Scene: "KID", NodeName: "KID", animatedNode: "skeleton", childNamesToBeReplaced: "Bu_Bu_0") else {return}
        
        //x: -0.07, y: 0, z: 0.067
        guard let player2 = createAnimatedPlayer(ludoBoard: ludoBoard, position : SCNVector3(
            self.ludoBoard.position.x-0.07,
            self.ludoBoard.position.y,
            self.ludoBoard.position.z+0.067), ArmyType: "RED", number: 2, Scene: "KID", NodeName: "KID", animatedNode: "skeleton", childNamesToBeReplaced: "Bu_Bu_0") else {return}
        
        //x: -0.1, y: 0, z: 0.067
        guard let player3 = createAnimatedPlayer(ludoBoard: ludoBoard, position : SCNVector3(
            self.ludoBoard.position.x-0.1,
            self.ludoBoard.position.y,
            self.ludoBoard.position.z+0.067), ArmyType: "RED", number: 3, Scene: "KID", NodeName: "KID", animatedNode: "skeleton", childNamesToBeReplaced: "Bu_Bu_0") else {return}
        
        //x: -0.1, y: 0, z: 0.1
        guard let player4 = createAnimatedPlayer(ludoBoard: ludoBoard, position : SCNVector3(
            self.ludoBoard.position.x-0.1,
            self.ludoBoard.position.y,
            self.ludoBoard.position.z+0.1), ArmyType: "RED", number: 4, Scene: "KID", NodeName: "KID", animatedNode: "skeleton", childNamesToBeReplaced: "Bu_Bu_0") else {return}
        
        redPlayerArmy += [player1,player2,player3,player4]
        
        redPlayerArmy.remove(at: 0)
        
        for player in redPlayerArmy
        {
            node.addChildNode(player.player)
            print("\(player.player.name!) added in RED ARMY")
        }
        
    }
    
    
    
    
    func runDice(vertical:Int, horizontal:Int)
    {
        let ballIndex = DiceNumber-1
        let node = Dragonballs[previousBall-1]
        node.isHidden = false
        node.position = ludoBoard.position
        node.position.y = ludoBoard.position.y + 0.05 //BallPosition
        node.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 22, z: 0, duration: 0.2)))
        node.runAction(SCNAction.scale(to: CGFloat.zero, duration: 0.3)) {
            node.isHidden = true
            self.Dragonballs[ballIndex].position = self.ludoBoard.position
            self.Dragonballs[ballIndex].position.y = self.ludoBoard.position.y + 0.05//BallPosition
            self.Dragonballs[ballIndex].scale = SCNVector3Zero
            self.Dragonballs[ballIndex].isHidden = false
            
            self.Dragonballs[ballIndex].runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 22, z: 0, duration: 0.2)))
            self.Dragonballs[ballIndex].runAction(SCNAction.scale(to: CGFloat(0.5), duration: 0.3)){
                
                self.Dragonballs[ballIndex].removeAllActions()
                self.previousBall = self.DiceNumber
            }
        }
    }
    
    func scaleMainNode(with scale:SCNVector3)
    {
        sceneView.scene.rootNode.scale.x += scale.x
        sceneView.scene.rootNode.scale.y += scale.y
        sceneView.scene.rootNode.scale.z += scale.z
        MainNode.scale = sceneView.scene.rootNode.scale


    }
    @objc func scalePiece(_ gestureRecognizer : UIPinchGestureRecognizer) {   guard gestureRecognizer.view != nil else { return }
    if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
//        MainNode.scale = SCNVector3(gestureRecognizer.scale, gestureRecognizer.scale, gestureRecognizer.scale)
//        gestureRecognizer.scale = 1.0
        scaleMainNode(with: SCNVector3(0.1,0.1,0.1))
//        MainNode.removeFromParentNode()
//        sceneView.scene.rootNode.addChildNode(MainNode)
//        print("MainNode : \(MainNode.scale)")
//        print("RootNode : \(sceneView.scene.rootNode.scale)")
       
    }}
    
    func MoveThatFuckinPlayers(player:Players, Army:String, hasAnimations:Bool=false, completionHandler : ()->()) ->Players
    {
        
        if player.isAtHome && DiceNumber == 6
        {
            if hasAnimations
            {
                print("playin the animation")
                player.player.animationPlayer(forKey: NodeKeyDict[Army]!)?.play()
            }
            
            player.stepsTaken = 1
            player.move(dice: Int(DiceNumber),
                        stepsTaken: player.stepsTaken,
                        stepDict: player.stepLogDict, animation: NodeanimationDict[Army]!, key: NodeKeyDict[Army]!, hasAnimations: hasAnimations
            )
            player.isAtHome = false
            
            PlayersOut[Army] = true
            rollDice=true
            
        }
        else if !player.isAtHome
        {
            if hasAnimations
            {
                print("playin the animation")
                player.player.animationPlayer(forKey: NodeKeyDict[Army]!)?.play()
            }
            
            player.stepsTaken += Int(DiceNumber)
            
            player.move(dice: Int(DiceNumber),
                        stepsTaken: player.stepsTaken,
                        stepDict: player.stepLogDict, animation: NodeanimationDict[Army]!, key: NodeKeyDict[Army]!, hasAnimations: hasAnimations
            )
            rollDice=true
            
        }
        else
        {
            if PlayersOut[Army]! // do something about it
            {
                rollDice=false
                print("[\(Army)] Move your out player bro!")
                switch Army
                {
                case "RED": whoseTurnItIs = .RED
                case "GREEN": whoseTurnItIs = .Green
                default:print("Nothing")
                }
            }
            else
            {
                rollDice=true
                print("[\(Army)] Get out of the home first bro!")
            }
            
        }
        completionHandler()
        return player
    }
    
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //DICE
        if rollDice
        {
            DiceNumber=0
            guard let touch = touches.first else {return}
            let touchLocation = touch.location(in: sceneView)
            let resultsOf3dTap = sceneView.hitTest(touchLocation, options: nil)
            if !resultsOf3dTap.isEmpty
            {
                guard let tapResultNode = resultsOf3dTap.first?.node else {return}
                if tapResultNode.name == "Dragon_Balls_07" ||
                    tapResultNode.name == "Dragon_Balls_01" ||
                    tapResultNode.name == "Dragon_Balls_02" ||
                    tapResultNode.name == "Dragon_Balls_03" ||
                    tapResultNode.name == "Dragon_Balls_04" ||
                    tapResultNode.name == "Dragon_Balls_05" ||
                    tapResultNode.name == "Dragon_Balls_06"
                {
                    //User correctly Rolled the dice
                    // Now he should move the player
                    
                    let randomDiceNumber = arc4random_uniform(6) + 1
                    DiceNumber = Int(randomDiceNumber)
                    print("Random Number is : \(randomDiceNumber)")
                    switch randomDiceNumber
                    {
                    case 1 : runDice(vertical: 180*4, horizontal: 180*4)
                    case 2 : runDice(vertical: 360*6, horizontal: 90*13)
                    case 3 : runDice(vertical: -90*13, horizontal: 360*6)
                    case 4 : runDice(vertical: 90*13, horizontal: 360*6)
                    case 5 : runDice(vertical: 360*6, horizontal: 90*11)
                    case 6 : runDice(vertical: 360*6, horizontal: 90*10)
                    default:
                        return
                    }
                    rollDice = false
                }
                else
                {
                    //user didnt rolled the dice and tapped somewhere else by mistake
                    //So he should roll the dice again
                    print("DICE : \(tapResultNode.name) tapped by mistake")
                    rollDice = true
                }
            }
            
        }
        else
        {
            //rollDice = true
            guard let touch = touches.first else {return}
            let touchLocation = touch.location(in: sceneView)
            let resultsOf3dTap = sceneView.hitTest(touchLocation, options: nil)
            if !resultsOf3dTap.isEmpty
            {
                guard let tapResultNode = resultsOf3dTap.first?.node else {return}
                let name = tapResultNode.name
                var playerIndex=0
                switch whoseTurnItIs
                {
                case .RED:
                    switch name
                    {
                    case "RED1" : playerIndex = 0
                    whoseTurnItIs = DiceNumber == 6 ? .RED : .Green
                    redPlayerArmy[playerIndex] = MoveThatFuckinPlayers(player: redPlayerArmy[playerIndex], Army: "RED", hasAnimations: true) {
                        //self.redPlayerArmy[playerIndex].player.animationPlayer(forKey: self.KIDKey)?.stop()
                        print("DONE WHOLE THING")
                        }
                        
                    case "RED2" : playerIndex = 1
                    whoseTurnItIs = DiceNumber == 6 ? .RED : .Green
                    redPlayerArmy[playerIndex] = MoveThatFuckinPlayers(player: redPlayerArmy[playerIndex], Army: "RED", hasAnimations: true, completionHandler:
                        {
                            //self.redPlayerArmy[playerIndex].player.animationPlayer(forKey: self.KIDKey)?.stop()
                            print("STOPPED")
                            
                    })
                        
                    case "RED3" : playerIndex = 2
                    whoseTurnItIs = DiceNumber == 6 ? .RED : .Green
                    redPlayerArmy[playerIndex] = MoveThatFuckinPlayers(player: redPlayerArmy[playerIndex], Army: "RED", hasAnimations: true, completionHandler:
                        {
                            // self.redPlayerArmy[playerIndex].player.animationPlayer(forKey: self.KIDKey)?.stop()
                            print("STOPPED")
                            
                    })
                        
                    case "RED4" : playerIndex = 3
                    whoseTurnItIs = DiceNumber == 6 ? .RED : .Green
                    redPlayerArmy[playerIndex] = MoveThatFuckinPlayers(player: redPlayerArmy[playerIndex], Army: "RED", hasAnimations: true, completionHandler:
                        {
                            //self.redPlayerArmy[playerIndex].player.animationPlayer(forKey: self.KIDKey)?.stop()
                            print("STOPPED")
                            
                    })
                        
                    default:
                        //user tapped somewhere else by mistake
                        //so he should tap the player again
                        rollDice=false
                        print("RED : \(name) tapped by mistake")
                        whoseTurnItIs = .RED
                    }
                case .Green:
                    switch name
                    {
                    case "GREEN1" : playerIndex = 0
                    whoseTurnItIs = DiceNumber == 6 ? .Green : .RED
                    greenPlayerArmy[playerIndex] = MoveThatFuckinPlayers(player: greenPlayerArmy[playerIndex], Army: "GREEN", hasAnimations: true, completionHandler: {})
                        
                    case "GREEN2" : playerIndex = 1
                    whoseTurnItIs = DiceNumber == 6 ? .Green : .RED
                    greenPlayerArmy[playerIndex] = MoveThatFuckinPlayers(player: greenPlayerArmy[playerIndex], Army: "GREEN", hasAnimations: true, completionHandler: {})
                        
                    case "GREEN3" : playerIndex = 2
                    whoseTurnItIs = DiceNumber == 6 ? .Green : .RED
                    greenPlayerArmy[playerIndex] = MoveThatFuckinPlayers(player: greenPlayerArmy[playerIndex], Army: "GREEN", hasAnimations: true, completionHandler: {})
                        
                    case "GREEN4" : playerIndex = 3
                    whoseTurnItIs = DiceNumber == 6 ? .Green : .RED
                    greenPlayerArmy[playerIndex] = MoveThatFuckinPlayers(player: greenPlayerArmy[playerIndex], Army: "GREEN", hasAnimations: true, completionHandler: {})
                    default:
                        //user tapped somewhere else by mistake
                        //so he should tap the player again
                        rollDice=false
                        print("GREEN : \(name) tapped by mistake")
                        whoseTurnItIs = .Green
                        
                    }
                }
                
                
            }
        }
    }
    
    
    func LoadLudoBoard(withNode node:SCNNode, andAnchor anchor:ARPlaneAnchor)
    {
        if boardLoaded == false
        {
            self.ludoBoard.position = SCNVector3(anchor.center.x, 0, anchor.center.z)
            
            initializeREDArmy(node:node)
            initializeGREENArmy(node:node)

            for ball in Dragonballs
            {
                ball.position = ludoBoard.position
                ball.position.y = ludoBoard.position.y + 0.05
                ball.scale = SCNVector3Make(0.5, 0.5, 0.5)
                node.addChildNode(ball)
            }
                        
            Dragonballs[previousBall-1].isHidden = false
            
            node.addChildNode(Dragonballs[previousBall-1])
            node.addChildNode(self.ludoBoard)
            MainNode = node
            node.removeFromParentNode()
            sceneView.scene.rootNode.addChildNode(MainNode)
            boardLoaded=true
            print("Loaded")
        }
        else{
            print("Not loaded")
        }
    }
    
    
    
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    

    
    
    
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor)
    {
        
        if let planeAnchor = anchor as? ARPlaneAnchor
        {
            
            LoadLudoBoard(withNode: node, andAnchor: planeAnchor)
            print("Flat surface detected")
        }
        else
        {
            return
        }
        
    }
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        print("called")
        if let planeAnchor = anchor as? ARPlaneAnchor
        {
            MainNode.scale = sceneView.scene.rootNode.scale
            
            MainNode.eulerAngles = sceneView.scene.rootNode.eulerAngles

        }
        else
        {
            return
        }
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
extension Int {
    
    var degreesToRadians: Double { return Double(self) * .pi/180}
}

extension Float {
    
    var RadiansToDegree: Float { return Float(self) / .pi*180}
}


