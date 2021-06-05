//
//  GameViewController.swift
//  Terraqueous
//
//  Created by DM on 9/23/17.
//  Copyright (c) 2017 DM. All rights reserved.
//

import SceneKit
import QuartzCore

class GameViewController: NSViewController {
    
    @IBOutlet weak var gameView: GameView!
    
    let scene = SCNScene(named: "art.scnassets/dae files/world.dae")!
    fileprivate let cameraNode = SCNNode()
    fileprivate let lightNode = SCNNode()
    fileprivate let ambientLightNode = SCNNode()
    fileprivate var faceNode = SCNNode()
    fileprivate var lithosphereNode = SCNNode()
    fileprivate var atmosphereNode = SCNNode()
    fileprivate var biosphereNode = SCNNode()
    fileprivate var hydrosphereNode = SCNNode()
    fileprivate var exosphereNode = SCNNode()
    fileprivate var armature = SCNNode()
    fileprivate var boneNode0 = SCNNode()
    fileprivate var boneNode1 = SCNNode()
    fileprivate var boneNode2 = SCNNode()
    fileprivate var boneNode3 = SCNNode()
    fileprivate var boneNode4 = SCNNode()
    fileprivate var boneNode5 = SCNNode()
    fileprivate var boneNode6 = SCNNode()
    fileprivate var boneNode7 = SCNNode()
    fileprivate var boneNode8 = SCNNode()
    fileprivate var boneNode9 = SCNNode()
    fileprivate var boneNode10 = SCNNode()
    fileprivate var boneNode11 = SCNNode()
    fileprivate var boneNode12 = SCNNode()
    fileprivate var boneNode13 = SCNNode()
    fileprivate var boneNode14 = SCNNode()
    fileprivate var boneNode15 = SCNNode()
    fileprivate var boneNode16 = SCNNode()
    fileprivate var boneNode17 = SCNNode()
    fileprivate var world = SCNNode()
    fileprivate var land = SCNNode()
    fileprivate var sea = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //lights and camera
        
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        cameraNode.position = SCNVector3(x: 0, y: -2, z: 13)
        
        lightNode.light = SCNLight()
        lightNode.light!.type = SCNLight.LightType.omni
        lightNode.position = SCNVector3(x: -10, y: 3, z: 0)
        scene.rootNode.addChildNode(lightNode)
        
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = SCNLight.LightType.ambient
        ambientLightNode.light!.color = NSColor.darkGray
        scene.rootNode.addChildNode(ambientLightNode)
        
        //face and buttons
        
        faceNode = createSpriteNode("faceImage", widthX: 4, heightY: 4, positionX: 0, positionY: -0.5, positionZ: 4.5)
        lithosphereNode = createSpriteNode("Lithosphere", widthX: 0.5, heightY: 0.5, positionX: -3.5, positionY: -3.4, positionZ: 9)
        atmosphereNode = createSpriteNode("Atmosphere", widthX: 0.5, heightY: 0.5, positionX: -1.8, positionY: -3.4, positionZ: 9)
        biosphereNode = createSpriteNode("Biosphere", widthX: 0.5, heightY: 0.5, positionX: -0, positionY: -3.4, positionZ: 9)
        hydrosphereNode = createSpriteNode("Hydrosphere", widthX: 0.5, heightY: 0.5, positionX: 1.8, positionY: -3.4, positionZ: 9)
        exosphereNode = createSpriteNode("Exosphere", widthX: 0.5, heightY: 0.5, positionX: 3.5, positionY: -3.4, positionZ: 9)
        
        //create shaderized materials
        
        let landMaterial = createMaterialWithShaders("", surface: "brown", lighting: "toonLighting2", fragment: "")
        let seaMaterial = createMaterialWithShaders("", surface: "blue", lighting: "toonLighting", fragment: "")
        
        // set world, land, and sea nodes from DAE file
        
        world = scene.rootNode.childNode(withName: "worldNode", recursively: true)!
        
        land = scene.rootNode.childNode(withName: "landNode", recursively: true)!
        land.childNode(withName: "Icosphere", recursively: true)!.geometry?.materials = [landMaterial]
        
        sea = scene.rootNode.childNode(withName: "seaNode", recursively: true)!
        sea.childNode(withName: "Icosphere_001", recursively: true)!.geometry?.materials = [seaMaterial]
        
        //set bones
        
        armature = scene.rootNode.childNode(withName: "armatureNode", recursively: true)!
        
        boneNode0 = armature.childNode(withName: "boneNode0", recursively: true)!
        boneNode1 = armature.childNode(withName: "boneNode1", recursively: true)!
        boneNode2 = armature.childNode(withName: "boneNode2", recursively: true)!
        boneNode3 = armature.childNode(withName: "boneNode3", recursively: true)!
        boneNode4 = armature.childNode(withName: "boneNode4", recursively: true)!
        boneNode5 = armature.childNode(withName: "boneNode5", recursively: true)!
        boneNode6 = armature.childNode(withName: "boneNode6", recursively: true)!
        boneNode7 = armature.childNode(withName: "boneNode7", recursively: true)!
        boneNode8 = armature.childNode(withName: "boneNode8", recursively: true)!
        boneNode9 = armature.childNode(withName: "boneNode9", recursively: true)!
        boneNode10 = armature.childNode(withName: "boneNode10", recursively: true)!
        boneNode11 = armature.childNode(withName: "boneNode11", recursively: true)!
        boneNode12 = armature.childNode(withName: "boneNode12", recursively: true)!
        boneNode13 = armature.childNode(withName: "boneNode13", recursively: true)!
        boneNode14 = armature.childNode(withName: "boneNode14", recursively: true)!
        boneNode15 = armature.childNode(withName: "boneNode15", recursively: true)!
        boneNode16 = armature.childNode(withName: "boneNode16", recursively: true)!
        boneNode17 = armature.childNode(withName: "boneNode17", recursively: true)!
        
        
        randomizeLand(armature)
        
        
        // animate the 3d object
        world.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 20)))
        let firstMove = SCNAction.moveBy(x: 10, y: 0, z: 15, duration: 10)
        firstMove.timingMode = SCNActionTimingMode.easeOut
        let secondMove = SCNAction.moveBy(x: 10, y: 0, z: -15, duration: 10)
        secondMove.timingMode = SCNActionTimingMode.easeIn
        let thirdMove = SCNAction.moveBy(x: -10, y: 0, z: -15, duration: 10)
        let fourthMove = SCNAction.moveBy(x: -10, y: 0, z: 15, duration: 10)
        fourthMove.timingMode = SCNActionTimingMode.easeIn
        
        //let procession = SCNAction.repeatActionForever(SCNAction.moveByX(0, y: -3, z: 0, duration: 75))
        //let orbitSmoother = SCNAction.repeatActionForever(SCNAction.moveByX(0, y: 0, z: 4, duration: 40))
        //orbitSmoother.timingMode = SCNActionTimingMode.EaseInEaseOut
        
        let sunOrbitalLighting = SCNAction.sequence([firstMove, secondMove, thirdMove, fourthMove])
        //let sunOrbitalLightingGroup = SCNAction.group([sunOrbitalLighting, procession])
        
        
        //let reverseSunOrbitalLighting = SCNAction.reversedAction(sunOrbitalLighting)
        
        lightNode.runAction(SCNAction.repeatForever(sunOrbitalLighting))
        
        //let scnView = self.view as! SCNView
        scene.background.contents = NSColor.init(red: 0.1, green: 0.1, blue: 0.1, alpha: 1)
        self.gameView!.scene = scene
        
        // allows the user to manipulate the camera
        self.gameView!.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        self.gameView!.showsStatistics = true
        
        // allows the user to manipulate the camera
        //scnView.allowsCameraControl = true
        
        // show statistics such as fps and timing information
        //scnView.showsStatistics = true
        
        // configure the view
        
        //arc4random(arc4random(5));
        
        let ranNum = 1 + arc4random() % 4;
        var cloudText = "art.scnassets/dae files/cloud"
        cloudText.append(String(ranNum))
        cloudText.append(".dae")
        
        print(cloudText)
        
        let cloudNode = (SCNScene(named: cloudText)!).rootNode.childNode(withName: "cloudNode", recursively: true)!
        
        for childNode in cloudNode.childNodes {
            childNode.geometry?.materials = [createMaterialWithShaders("", surface: "cloudColor", lighting: "toonLighting3", fragment: "")]
        }
        
        scene.rootNode.addChildNode(cloudNode)
        cloudNode.position = SCNVector3Make(0, 0, 0)
        
        cloudNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 4, z: 0, duration: 20)))
        
        // add a tap gesture recognizer
        /*let tapGesture = UITapGestureRecognizer(target: self, action: "handleTap:")
         var gestureRecognizers = [UIGestureRecognizer]()
         gestureRecognizers.append(tapGesture)
         if let existingGestureRecognizers = scnView.gestureRecognizers {
         gestureRecognizers.appendContentsOf(existingGestureRecognizers)
         }
         scnView.gestureRecognizers = gestureRecognizers*/
    }
    
    /*func handleTap(gestureRecognize: UIGestureRecognizer) {
     // retrieve the SCNView
     let scnView = self.view as! SCNView
     
     // check what nodes are tapped
     let p = gestureRecognize.locationInView(scnView)
     let hitResults = scnView.hitTest(p, options: nil)
     // check that we clicked on at least one object
     if hitResults.count > 0 {
     // retrieved the first clicked object
     let result: AnyObject! = hitResults[0]
     
     // get its material
     let material = result.node!.geometry!.firstMaterial!
     
     // highlight it
     SCNTransaction.begin()
     SCNTransaction.setAnimationDuration(0.5)
     
     // on completion - unhighlight
     SCNTransaction.setCompletionBlock {
     SCNTransaction.begin()
     SCNTransaction.setAnimationDuration(0.5)
     
     material.emission.contents = UIColor.blackColor()
     
     SCNTransaction.commit()
     }
     
     material.emission.contents = UIColor.redColor()
     
     SCNTransaction.commit()
     }
     }*/
    
    /*override func didReceiveMemoryWarning() {
     super.didReceiveMemoryWarning()
     // Release any cached data, fs, etc that aren't in use.
     }*/
    
    fileprivate func createSpriteNode(_ fileName: String, widthX: CGFloat, heightY: CGFloat, positionX: Float, positionY: Float, positionZ: Float) ->SCNNode {
        
        
        var spNode = SCNNode()
        var pathString = "art.scnassets/images/"
        pathString.append(fileName)
        let fileType = "png"
        
        let spImage = NSImage.init(contentsOfFile: Bundle.main.path(forResource: pathString, ofType: fileType)!)
        let spMaterial = SCNMaterial()
        var spPlane: SCNPlane
            
        spMaterial.diffuse.contents = spImage
        spMaterial.lightingModel = SCNMaterial.LightingModel(rawValue: "SCNLightingModelConstant")
            
            
        spPlane = SCNPlane.init(width: widthX, height: heightY)
        spPlane.materials = [spMaterial]
            
        spNode = SCNNode.init(geometry: spPlane)
        spNode.position = SCNVector3(x: CGFloat(positionX), y: CGFloat(positionY), z: CGFloat(positionZ)
        )
        scene.rootNode.addChildNode(spNode)

        return spNode
    }
    
    fileprivate func createMaterialWithShaders(_ geometry: String = "", surface: String = "", lighting: String = "", fragment: String = "") ->SCNMaterial {
        //works on .shader files only in the shader folder. Back face culling enabled
        let newMaterial = SCNMaterial()
        var shaders = [SCNShaderModifierEntryPoint: String]()
        var path = ""
        
        if geometry != "" {
            path = Bundle.main.path(forResource: geometry, ofType: "shader", inDirectory: "art.scnassets/shaders")!
            
            do{
                let newShader = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                shaders[SCNShaderModifierEntryPoint.geometry] = newShader
                
            }catch let error as NSError{
                error.description
            }
        }
        
        if surface != "" {
            path = Bundle.main.path(forResource: surface, ofType: "shader", inDirectory: "art.scnassets/shaders")!
            
            do{
                let newShader = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                shaders[SCNShaderModifierEntryPoint.surface] = newShader
                
            }catch let error as NSError{
                error.description
            }
        }
        
        if lighting != "" {
            path = Bundle.main.path(forResource: lighting, ofType: "shader", inDirectory: "art.scnassets/shaders")!
            
            do{
                let newShader = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                shaders[SCNShaderModifierEntryPoint.lightingModel] = newShader
                
            }catch let error as NSError{
                error.description
            }
        }
        
        if fragment != "" {
            path = Bundle.main.path(forResource: fragment, ofType: "shader", inDirectory: "art.scnassets/shaders")!
            
            do{
                let newShader = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
                shaders[SCNShaderModifierEntryPoint.fragment] = newShader
                
            }catch let error as NSError{
                error.description
            }
        }
        
        newMaterial.shaderModifiers = shaders
        newMaterial.cullMode = SCNCullMode.back
        
        return newMaterial
    }
    
    fileprivate func randomizeLand(_ armature: SCNNode) {
        // 17 bones
        //arc4random(arc4random(3))
        
        var ranNum = arc4random() % 17
        //var newRanNum: Int32
        let preText = "boneNode"
        var nodeText = preText
        nodeText.append(String(ranNum))
        
        armature.childNode(withName: nodeText, recursively: true)?.runAction(SCNAction.scale(by: 1.1, duration: 5))
        
        ranNum = arc4random() % 17
        nodeText = preText
        nodeText.append(String(ranNum))
        
        armature.childNode(withName: nodeText, recursively: true)?.runAction(SCNAction.scale(by: 1.1, duration: 5))
        
        ranNum = arc4random() % 17;
        nodeText = preText
        nodeText.append(String(ranNum))
        
        armature.childNode(withName: nodeText, recursively: true)?.runAction(SCNAction.scale(by: 1.1, duration: 5))
        
        ranNum = arc4random() % 17;
        nodeText = preText
        nodeText.append(String(ranNum))
        
        armature.childNode(withName: nodeText, recursively: true)?.runAction(SCNAction.scale(by: 1.1, duration: 5))
        
        ranNum = arc4random() % 17;
        nodeText = preText
        nodeText.append(String(ranNum))
        
        armature.childNode(withName: nodeText, recursively: true)?.runAction(SCNAction.scale(by: 1.1, duration: 5))
        
        
    }

}
