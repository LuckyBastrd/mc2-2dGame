//
//  AddHeroExtension.swift
//  BitRayed
//
//  Created by Ali Haidar on 20/06/24.
//

import SpriteKit

extension GameScene {
    func addHero() {
        hero = childNode(withName: "character") as! SKSpriteNode
        hero.zPosition = 50
        hero.physicsBody = SKPhysicsBody(texture: hisTexture, size: hero.size)
        hero.physicsBody?.categoryBitMask = bitMask.hero.rawValue
        hero.physicsBody?.contactTestBitMask = bitMask.wall.rawValue | bitMask.bed.rawValue
        hero.physicsBody?.collisionBitMask = bitMask.wall.rawValue | bitMask.bed.rawValue
        hero.physicsBody?.affectedByGravity = false
        hero.physicsBody?.allowsRotation = false
    }
}
