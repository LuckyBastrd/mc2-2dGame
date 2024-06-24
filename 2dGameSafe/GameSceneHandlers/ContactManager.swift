//
//  ContactManager.swift
//  2dGameSafe
//
//  Created by Hansen Yudistira on 24/06/24.
//

import SpriteKit

class ContactManager {
    weak var scene: GameScene?
    
    var bedTapable = false
    var drawerTapable = false
    var tvTapable = false
    var chestTapable = false
    
    var actionSign: SKSpriteNode? 

    init(scene: GameScene) {
        self.scene = scene
        self.actionSign = scene.hero.childNode(withName: "actionSign") as? SKSpriteNode
    }

    func handleContactBegin(contactA: String?, contactB: String?) {
        if (contactA == "character" && contactB == "bed") || (contactA == "bed" && contactB == "character") {
            bedTapable = true
            actionSign?.isHidden = false
            print("tap actionnya bro")
        }
        
        if (contactA == "character" && contactB == "drawer") || (contactA == "drawer" && contactB == "character") {
            drawerTapable = true
            actionSign?.isHidden = false
            print("tap actionnya bro 2")
        }
        
        if (contactA == "character" && contactB == "tv") || (contactA == "tv" && contactB == "character") {
            tvTapable = true
            actionSign?.isHidden = false
            print("tap actionnya bro 3")
        }
        
        if (contactA == "character" && contactB == "chest") || (contactA == "chest" && contactB == "character") {
            chestTapable = true
            actionSign?.isHidden = false
            print("tap actionnya bro 4")
        }
    }
    
    func handleContactEnd(contactA: String?, contactB: String?) {
        if (contactA == "character" && contactB == "bed") || (contactA == "bed" && contactB == "character") {
            bedTapable = false
            actionSign?.isHidden = true
        }
        
        if (contactA == "character" && contactB == "drawer") || (contactA == "drawer" && contactB == "character") {
            drawerTapable = false
            actionSign?.isHidden = true
        }
        
        if (contactA == "character" && contactB == "tv") || (contactA == "tv" && contactB == "character") {
            tvTapable = false
            actionSign?.isHidden = true
        }
        
        if (contactA == "character" && contactB == "chest") || (contactA == "chest" && contactB == "character") {
            chestTapable = false
            actionSign?.isHidden = true
        }
    }
}
