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
    var actionSign = SKSpriteNode()
    let hisTexture = SKTexture(imageNamed: "character")
    var moveToLeft = false
    var moveToRight = false
    var moveUp = false
    var moveDown = false
    var actionButton = false
    var isInteract = false
    var cameraNode = SKCameraNode()
    var warningSign: SKSpriteNode!
    var heroNode: SKSpriteNode!

    var contactManager: ContactManager!
    var viewControllerPresenter: ViewControllerPresenter!
    
    let collisionNames = ["bed", "drawer", "tv", "chest"]
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        setupCamera()
        
        addHero()
        
        addCollisions(names: collisionNames)
        
        contactManager = ContactManager(scene: self)
        
        viewControllerPresenter = ViewControllerPresenter(presentingViewController: viewController()!)
        
        for node in self.children {
            if(node.name == "wallPhysics") {
                if let someTileMap: SKTileMapNode = node as? SKTileMapNode {
                    tilePhysics(map: someTileMap)
//                    someTileMap.removeFromParent()
                }
                break
            }
        }
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
        if actionButton && contactManager.bedTapable {
            viewControllerPresenter.present(viewControllerType: .shadow)
        }
        if actionButton && contactManager.drawerTapable {
            viewControllerPresenter.present(viewControllerType: .drawer)
        }
        if actionButton && contactManager.chestTapable {
            viewControllerPresenter.present(viewControllerType: .safe)
        }
        if actionButton && contactManager.tvTapable {
            viewControllerPresenter.present(viewControllerType: .vent)
        }
        
        cameraNode.position = hero.position
//        
//        guard let heroNode = heroNode else { return }
//        let warningDistanceThreshold: CGFloat = 10.0
//        
//        var closestFurnitureNode: SKNode?
//        var minDistance: CGFloat = .greatestFiniteMagnitude
//        
//        self.enumerateChildNodes(withName: "furniture") { node, _ in
//            let distance = hypot(heroNode.position.x - node.position.x, heroNode.position.y - node.position.y)
//            if distance < minDistance {
//                minDistance = distance
//                closestFurnitureNode = node
//            }
//        }
//        
//        if let closestFurnitureNode = closestFurnitureNode, minDistance < warningDistanceThreshold {
//            warningSign.position = CGPoint(x: closestFurnitureNode.position.x, y: closestFurnitureNode.position.y + 50) // Adjust position as needed
//            warningSign.isHidden = false
//        } else {
//            warningSign.isHidden = true
//        }
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        contactManager.handleContactBegin(contactA: contact.bodyA.node?.name, contactB: contact.bodyB.node?.name)
    }
    
    public func didEnd(_ contact: SKPhysicsContact) {
        contactManager.handleContactEnd(contactA: contact.bodyA.node?.name, contactB: contact.bodyB.node?.name)
    }
    
    private func showActionSign(){
        
    }
    
    func savePuzzleState(puzzleID: String, isSolved: Bool) {
        UserDefaults.standard.set(isSolved, forKey: puzzleID)
    }
    
    func loadPuzzleState(puzzleID: String) -> Bool {
        return UserDefaults.standard.bool(forKey: puzzleID)
    }
}
