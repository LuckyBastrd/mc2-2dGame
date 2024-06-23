//
//  GameScene.swift
//  BitRayed
//
//  Created by Ali Haidar on 20/06/24.
//

import Foundation
import SpriteKit
import AVFoundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var hero = SKSpriteNode()
    var stuff = SKSpriteNode()
    let hisTexture = SKTexture(imageNamed: "character")
    var moveToLeft = false
    var moveToRight = false
    var moveUp = false
    var moveDown = false
    var isInteract = false
    var cameraNode = SKCameraNode()
    var warningSign: SKSpriteNode!
    var heroNode: SKSpriteNode!
    
    let collisionNames = ["bed", "drawer", "tv", "chest"]
    
    enum bitMask: UInt32 {
        case hero = 0b1
        case wall = 0b10
        case bed = 0b100
        case ground = 0b1000
    }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        setupCamera()
        
        addHero()
        
        addCollisions(names: collisionNames)
        
        for node in self.children {
            if(node.name == "wallPhysics") {
                if let someTileMap: SKTileMapNode = node as? SKTileMapNode {
                    tilePhysics(map: someTileMap)
//                    someTileMap.removeFromParent()
                }
                break
            }
        }
        
        // Create the warning sign node
        warningSign = SKSpriteNode(imageNamed: "warning")
        warningSign.position = CGPoint(x: 0, y: 0)
        warningSign.zPosition = 5 // Ensure it's drawn above other nodes
        warningSign.isHidden = true
        self.addChild(warningSign)
        
        // Find or create your hero node
        // Example:
        heroNode = self.childNode(withName: "hero") as? SKSpriteNode
        
        
    }
    
    
    func setupCamera() {
        cameraNode = SKCameraNode()
        cameraNode.xScale = 0.2
        cameraNode.yScale = 0.2
        camera = cameraNode
        addChild(cameraNode)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: self)
            let touchNode = self.nodes(at: position)
            
            for node in touchNode {
                if node.name == "left" {
                    moveToLeft = true
                }
                if node.name == "right" {
                    moveToRight = true
                }
                if node.name == "up" {
                    moveUp = true
                }
                if node.name == "down" {
                    moveDown = true
                }
                if node.name == "interact" {
                    isInteract = true
                }
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let position = touch.location(in: self)
            let touchNode = self.nodes(at: position)
            
            for node in touchNode {
                if node.name == "left" {
                    moveToLeft = false
                }
                if node.name == "right" {
                    moveToRight = false
                }
                if node.name == "up" {
                    moveUp = false
                }
                if node.name == "down" {
                    moveDown = false
                }
                if node.name == "interact" {
                    isInteract = false
                }
            }
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if moveToLeft {
            hero.position.x -= 2
        }
        if moveToRight {
            hero.position.x += 2
        }
        if moveUp {
            hero.position.y += 2
        }
        if moveDown {
            hero.position.y -= 2
        }
        
        cameraNode.position = hero.position
        
        guard let heroNode = heroNode else { return }

                let warningDistanceThreshold: CGFloat = 10.0 // Adjust this value as needed
                
                var closestFurnitureNode: SKNode?
                var minDistance: CGFloat = .greatestFiniteMagnitude
                
                self.enumerateChildNodes(withName: "furniture") { node, _ in
                    let distance = hypot(heroNode.position.x - node.position.x, heroNode.position.y - node.position.y)
                    if distance < minDistance {
                        minDistance = distance
                        closestFurnitureNode = node
                    }
                }
                
                if let closestFurnitureNode = closestFurnitureNode, minDistance < warningDistanceThreshold {
                    warningSign.position = CGPoint(x: closestFurnitureNode.position.x, y: closestFurnitureNode.position.y + 50) // Adjust position as needed
                    warningSign.isHidden = false
                } else {
                    warningSign.isHidden = true
                }
    }
    
    
}
