//
//  AddCollisionExtension.swift
//  BitRayed
//
//  Created by Ali Haidar on 20/06/24.
//

import SpriteKit

extension GameScene {
    func addCollisions(names: [String]) {
        for name in names {
            if let node = childNode(withName: name) as? SKSpriteNode {
                node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
                node.physicsBody?.isDynamic = false
                node.physicsBody?.categoryBitMask = bitMask.bed.rawValue
                node.physicsBody?.contactTestBitMask = bitMask.hero.rawValue
                node.physicsBody?.collisionBitMask = bitMask.hero.rawValue
                node.zPosition = 4
            }
        }
    }
}
