//
//  MapCreator.swift
//  2dGameSafe
//
//  Created by Hansen Yudistira on 19/06/24.
//
import SpriteKit

class MapCreator {
    let tileTemplateLMargin = 24.0 //half L tiles margin
    let tileTemplateHMargin = 8.0 //half tiles height margin
    let tileTemplateWMargin = 16.0 //half tiles width margin
    let tileWidth = 32.0 //full tiles width margin
    let tileTemplateLWMargin = 48.0 //full L tiles margin
    
    func createTileTemplate() -> SKSpriteNode {
        let tile = SKSpriteNode(imageNamed: "tilesGrass")
        tile.size = CGSize(width: 32, height: 16)
        tile.physicsBody = SKPhysicsBody(rectangleOf: tile.size)
        tile.physicsBody?.isDynamic = false
        return tile
    }
    
    func createTileTemplateL() -> SKSpriteNode {
        let tile = SKSpriteNode(imageNamed: "tilesGrassL")
        tile.size = CGSize(width: 48, height: 48)
        tile.physicsBody = SKPhysicsBody(texture: tile.texture!, size: tile.size)
        tile.physicsBody?.isDynamic = false
        return tile
    }
    
    func createMainRoom() -> SKSpriteNode {
        let yStart: CGFloat = -512.0
        let yEnd: CGFloat = 512.0
        let xStart: CGFloat = 0.0
        let xEnd: CGFloat = 1024.0
        
        let mainRoomNode = SKSpriteNode()
        
        let tileTemplate = createTileTemplate()
        let tileTemplateL = createTileTemplateL()
        
        let tileLbottomLeftCorner = tileTemplateL.copy() as! SKSpriteNode
        tileLbottomLeftCorner.position = CGPoint(x: xStart + tileTemplateLMargin, y: yStart + tileTemplateLMargin)
        mainRoomNode.addChild(tileLbottomLeftCorner)
        let tileLbottomRightCorner = tileTemplateL.copy() as! SKSpriteNode
        tileLbottomRightCorner.position = CGPoint(x: xEnd - tileTemplateLMargin, y: yStart + tileTemplateLMargin)
        tileLbottomRightCorner.zRotation = .pi / 2
        mainRoomNode.addChild(tileLbottomRightCorner)
        let tileLtopLeftCorner = tileTemplateL.copy() as! SKSpriteNode
        tileLtopLeftCorner.position = CGPoint(x: xStart + tileTemplateLMargin, y: yEnd - tileTemplateLMargin)
        tileLtopLeftCorner.zRotation = .pi / 2 + .pi
        mainRoomNode.addChild(tileLtopLeftCorner)
        let tileLtopRightCorner = tileTemplateL.copy() as! SKSpriteNode
        tileLtopRightCorner.position = CGPoint(x: xEnd - tileTemplateLMargin, y: yEnd - tileTemplateLMargin)
        tileLtopRightCorner.zRotation = .pi
        mainRoomNode.addChild(tileLtopRightCorner)
        
        var xPosition = xStart + tileTemplateLMargin + tileTemplateWMargin
        let xLast = xEnd - tileTemplateLMargin - tileTemplateWMargin
        while xPosition <= xLast {
            // Top edge
            let tile = tileTemplate.copy() as! SKSpriteNode
            tile.position = CGPoint(x: xPosition, y: yEnd - tileTemplateHMargin)
            tile.zRotation = .pi
            mainRoomNode.addChild(tile)
            // Bottom edge
            let tile2 = tileTemplate.copy() as! SKSpriteNode
            tile2.position = CGPoint(x: xPosition, y: yStart + tileTemplateHMargin)
            mainRoomNode.addChild(tile2)
            xPosition += tileWidth
        }
        
        // Left edge
        var yPosition = yStart + tileTemplateLWMargin + tileTemplateWMargin
        let yLast = yEnd - tileTemplateLWMargin - tileTemplateWMargin
        while yPosition <= yLast {
            let tile = tileTemplate.copy() as! SKSpriteNode
            tile.position = CGPoint(x: xStart + tileTemplateHMargin, y: yPosition)
            mainRoomNode.addChild(tile)
            tile.zRotation = .pi / 2 + .pi
            yPosition += tileWidth
        }
        
        // Right edge
        yPosition = yStart + tileTemplateLMargin + tileTemplateWMargin
        xPosition = xEnd - tileTemplateHMargin
        while yPosition < -128 {
            let tile = tileTemplate.copy() as! SKSpriteNode
            tile.position = CGPoint(x: xPosition, y: yPosition)
            tile.zRotation = .pi / 2
            mainRoomNode.addChild(tile)
            yPosition += tileWidth
        }
        
        yPosition = 128
        while yPosition < yEnd {
            let tile = tileTemplate.copy() as! SKSpriteNode
            tile.position = CGPoint(x: xPosition, y: yPosition)
            tile.zRotation = .pi / 2
            mainRoomNode.addChild(tile)
            yPosition += tileWidth
        }
        
        // corner wall on the right edge
        let tileLRight1 = tileTemplateL.copy() as! SKSpriteNode
        tileLRight1.position = CGPoint(x: xEnd, y: -128.0)
        tileLRight1.zRotation = .pi / 2 + .pi
        mainRoomNode.addChild(tileLRight1)
        
        let tileLRight2 = tileTemplateL.copy() as! SKSpriteNode
        tileLRight2.position = CGPoint(x: xEnd, y: 128.0)
        mainRoomNode.addChild(tileLRight2)
        
        // wall to the bathroom
        xPosition = xEnd + 160.0
        while xPosition <= 1248 {
            let tile = tileTemplate.copy() as! SKSpriteNode
            tile.position = CGPoint(x: xPosition, y: -120.0)
            mainRoomNode.addChild(tile)
            let tile2 = tileTemplate.copy() as! SKSpriteNode
            tile2.position = CGPoint(x: xPosition, y: 112.0)
            mainRoomNode.addChild(tile2)
            xPosition += tileWidth
        }
        
        // corner wall on bathroom edge
        let tileLRight3 = tileTemplateL.copy() as! SKSpriteNode
        tileLRight3.position = CGPoint(x: 1280, y: -104.0)
        tileLRight3.zRotation = .pi / 2
        mainRoomNode.addChild(tileLRight3)
        
        let tileLRight4 = tileTemplateL.copy() as! SKSpriteNode
        tileLRight4.position = CGPoint(x: 1280, y: 104.0)
        tileLRight4.zRotation = .pi
        mainRoomNode.addChild(tileLRight4)
        
        return mainRoomNode
    }
    
    func createBathroom() -> SKSpriteNode {
        let yStart: CGFloat = -128.0
        let yEnd: CGFloat = 128.0
        let xStart: CGFloat = 0.0
        let xEnd: CGFloat = 256.0
        
        let bathroomNode = SKSpriteNode()
        bathroomNode.position = CGPoint(x: 1280.0, y: 0)
        
        let tileTemplate = createTileTemplate()
        let tileTemplateL = createTileTemplateL()
        
        var xPosition = xStart
        var xLast = xEnd + tileTemplateLWMargin + tileTemplateWMargin
        let yTop = yEnd - tileTemplateHMargin
        let yBot = yStart + tileTemplateHMargin
        while xPosition <= xLast {
            // Top edge
            let tile = tileTemplate.copy() as! SKSpriteNode
            tile.position = CGPoint(x: xPosition, y: yTop)
            tile.zRotation = .pi
            bathroomNode.addChild(tile)
            // Bottom edge
            let tile2 = tileTemplate.copy() as! SKSpriteNode
            tile2.position = CGPoint(x: xPosition, y: yBot)
            bathroomNode.addChild(tile2)
            xPosition += tileWidth
        }
        
        xLast += tileTemplateHMargin
        let tileLRight1 = tileTemplateL.copy() as! SKSpriteNode
        tileLRight1.position = CGPoint(x: xLast, y: yStart + tileTemplateLMargin)
        tileLRight1.zRotation = .pi / 2
        bathroomNode.addChild(tileLRight1)
        
        let tileLRight2 = tileTemplateL.copy() as! SKSpriteNode
        tileLRight2.position = CGPoint(x: xLast, y: yEnd - tileTemplateLMargin)
        tileLRight2.zRotation = .pi
        bathroomNode.addChild(tileLRight2)
        
        // Right Edge
        var yPosition = yStart + tileTemplateLWMargin + tileTemplateWMargin
        let yLast = yEnd - tileTemplateLWMargin - tileTemplateWMargin
        xPosition = xLast + tileTemplateLMargin - tileTemplateHMargin
        while yPosition <=  yLast {
            let tile = tileTemplate.copy() as! SKSpriteNode
            tile.position = CGPoint(x: xPosition, y: yPosition)
            tile.zRotation = .pi / 2
            bathroomNode.addChild(tile)
            yPosition += tileWidth
        }
        
        return bathroomNode
    }
    
    func createWorkroom() -> SKSpriteNode {
        let yStart: CGFloat = 0.0
        let yEnd: CGFloat = yStart + 320.0
        let xStart: CGFloat = 0.0
        let xEnd: CGFloat = 560.0
        
        let workroomNode = SKSpriteNode()
        workroomNode.position = CGPoint(x: 1024, y: 512)
        
        let tileTemplate = createTileTemplate()
        let tileTemplateL = createTileTemplateL()
        
        //Left Edge
        var yPosition = yStart
        var xPosition = xStart - tileTemplateHMargin
        while yPosition <=  yEnd {
            let tile = tileTemplate.copy() as! SKSpriteNode
            tile.position = CGPoint(x: xPosition, y: yPosition)
            tile.zRotation = .pi / 2
            workroomNode.addChild(tile)
            yPosition += tileWidth
        }
        
        let tileLtopLeftCorner = tileTemplateL.copy() as! SKSpriteNode
        tileLtopLeftCorner.position = CGPoint(x: xStart, y: yEnd)
        tileLtopLeftCorner.zRotation = .pi / 2 + .pi
        workroomNode.addChild(tileLtopLeftCorner)
        
        //top Edge
        xPosition = xStart + tileTemplateLMargin
        yPosition = yEnd + tileTemplateLMargin - tileTemplateHMargin
        let xLast = xEnd + tileTemplateWMargin
        while xPosition <= xLast {
            let tile = tileTemplate.copy() as! SKSpriteNode
            tile.position = CGPoint(x: xPosition, y: yPosition)
            tile.zRotation = .pi
            workroomNode.addChild(tile)
            xPosition += tileWidth
        }
        
        // top right corner
        let tileLRight = tileTemplateL.copy() as! SKSpriteNode
        tileLRight.position = CGPoint(x: xEnd + tileTemplateLMargin, y: yEnd)
        tileLRight.zRotation = .pi
        workroomNode.addChild(tileLRight)
        
        // Right Edge
        yPosition = -384.0
        let yLast = yEnd - tileTemplateLMargin
        xPosition = xEnd + tileTemplateLWMargin - tileTemplateHMargin
        while yPosition <=  yLast {
            let tile = tileTemplate.copy() as! SKSpriteNode
            tile.position = CGPoint(x: xPosition, y: yPosition)
            tile.zRotation = .pi / 2
            workroomNode.addChild(tile)
            yPosition += tileWidth
        }
        
        return workroomNode
    }
    
    func createBedroom() -> SKSpriteNode {
        let yEnd: CGFloat = 0.0
        let yStart: CGFloat = yEnd - 320.0
        let xStart: CGFloat = 0
        let xEnd: CGFloat = 560.0
        
        let bedroomNode = SKSpriteNode()
        bedroomNode.position = CGPoint(x: 1024, y: -512)
        
        let tileTemplate = createTileTemplate()
        let tileTemplateL = createTileTemplateL()
        
        //Left Edge
        var yPosition = yStart
        var xPosition = xStart - tileTemplateHMargin
        while yPosition <=  yEnd {
            let tile = tileTemplate.copy() as! SKSpriteNode
            tile.position = CGPoint(x: xPosition, y: yPosition)
            tile.zRotation = .pi / 2
            bedroomNode.addChild(tile)
            yPosition += tileWidth
        }
        
        let tileLbotLeftCorner = tileTemplateL.copy() as! SKSpriteNode
        tileLbotLeftCorner.position = CGPoint(x: xStart, y: yStart)
        bedroomNode.addChild(tileLbotLeftCorner)
        
        //bot Edge
        xPosition = xStart + tileTemplateLMargin
        yPosition = yStart - tileTemplateHMargin
        let xLast = xEnd + tileTemplateWMargin
        while xPosition <= xLast {
            let tile = tileTemplate.copy() as! SKSpriteNode
            tile.position = CGPoint(x: xPosition, y: yPosition)
            tile.zRotation = .pi
            bedroomNode.addChild(tile)
            xPosition += tileWidth
        }
        
        // top right corner
        let tileLRight = tileTemplateL.copy() as! SKSpriteNode
        tileLRight.position = CGPoint(x: xEnd + tileTemplateLMargin, y: yStart)
        tileLRight.zRotation = .pi / 2
        bedroomNode.addChild(tileLRight)
        
        // Right Edge
        yPosition = yStart + tileTemplateLMargin
        let yLast = 384.0
        xPosition = xEnd + tileTemplateLMargin + tileTemplateWMargin
        while yPosition <=  yLast {
            let tile = tileTemplate.copy() as! SKSpriteNode
            tile.position = CGPoint(x: xPosition, y: yPosition)
            tile.zRotation = .pi / 2
            bedroomNode.addChild(tile)
            yPosition += tileWidth
        }
        
        return bedroomNode
    }
}
