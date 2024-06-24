//
//  MainGameView.swift
//  BitRayed
//
//  Created by Ali Haidar on 20/06/24.
//

import SwiftUI
import SpriteKit

struct MainGameView: View {
    
    var scene: SKScene = {
        let scene = GameScene(fileNamed: "MainScene.sks")!
        scene.scaleMode = .resizeFill
        return scene
    }()
    
    
    @State private var moveToLeft = false
    @State private var moveToRight = false
    
    var body: some View {
        ZStack {
            SpriteView(scene: scene)
            
            HStack {
                VStack {
                    Spacer()
                    HoldableButton(imageName: "arrowshape.up.circle.fill") {
                        (scene as? GameScene)?.moveUp = true
                    } onRelease: {
                        (scene as? GameScene)?.moveUp = false
                    }
                    HStack (spacing: 100){
                        
                        HoldableButton(imageName: "arrowshape.left.circle.fill") {
                            (scene as? GameScene)?.moveToLeft = true
                        } onRelease: {
                            (scene as? GameScene)?.moveToLeft = false
                        }
                        
                        HoldableButton(imageName: "arrowshape.right.circle.fill") {
                            (scene as? GameScene)?.moveToRight = true
                        } onRelease: {
                            (scene as? GameScene)?.moveToRight = false
                        }
                        
                    }
                    
                    HoldableButton(imageName: "arrowshape.down.circle.fill") {
                        (scene as? GameScene)?.moveDown = true
                    } onRelease: {
                        (scene as? GameScene)?.moveDown = false
                    }
                    
                    
                }
                Spacer()
                
                VStack() {
                    HoldableButton(imageName: "a.circle.fill") {
                        (scene as? GameScene)?.actionButton = true
                    } onRelease: {
                        (scene as? GameScene)?.actionButton = false
                    }
                }
                .offset(x: -100, y: 350)
            }
            .padding()
        }
        .ignoresSafeArea()
    }
}



#Preview {
    MainGameView()
}
