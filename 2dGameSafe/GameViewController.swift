import UIKit
import SpriteKit
import GameplayKit

public class GameViewController: UIViewController, SKPhysicsContactDelegate {
    
    private var scene: SKScene!
    private var sceneView = SKView()
    private var screenSize: CGSize!
    private var cameraNode: SKCameraNode!
    
    private var mapCreator = MapCreator()
    
    var selectedNode: SKSpriteNode!
    var humanNodeTappable = false
    var humanNodeTappable2 = false
    var humanNodeTappable3 = false
    var humanNodeTappable4 = false
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupScreenSize()
        setup()
        addTapGestureRecognizer()
    }
    
    private func setupScreenSize() {
        let screenBounds = UIScreen.main.bounds
        let screenWidth = max(screenBounds.width, screenBounds.height)
        let screenHeight = min(screenBounds.width, screenBounds.height)
        screenSize = CGSize(width: screenWidth, height: screenHeight)
        sceneView.frame = CGRect(origin: .zero, size: screenSize)
        view.addSubview(sceneView)
    }
    
    func setup() {
        scene = SKScene(size: screenSize)
        scene.scaleMode = .resizeFill
        scene.backgroundColor = .black
        
        scene.physicsWorld.contactDelegate = self
        
        let mainRoomNode = mapCreator.createMainRoom()
        let humanNode4 = SKSpriteNode(imageNamed: "human")
        humanNode4.size = CGSize(width: 48, height: 48)
        humanNode4.position = CGPoint(x: 0, y: 0)
        humanNode4.physicsBody = SKPhysicsBody(rectangleOf: humanNode4.size)
        humanNode4.physicsBody?.affectedByGravity = false
        humanNode4.physicsBody?.isDynamic = false
        humanNode4.physicsBody?.categoryBitMask = bitMasks.human.rawValue
        humanNode4.physicsBody?.collisionBitMask = bitMasks.ghost.rawValue
        humanNode4.physicsBody?.contactTestBitMask = bitMasks.ghost.rawValue
        humanNode4.name = "human4"
        mainRoomNode.addChild(humanNode4)
        scene.addChild(mainRoomNode)
        
        let bathRoomNode = mapCreator.createBathroom()
        let humanNode3 = SKSpriteNode(imageNamed: "human")
        humanNode3.size = CGSize(width: 48, height: 48)
        humanNode3.position = CGPoint(x: 0, y: 0)
        humanNode3.physicsBody = SKPhysicsBody(rectangleOf: humanNode3.size)
        humanNode3.physicsBody?.affectedByGravity = false
        humanNode3.physicsBody?.isDynamic = false
        humanNode3.physicsBody?.categoryBitMask = bitMasks.human.rawValue
        humanNode3.physicsBody?.collisionBitMask = bitMasks.ghost.rawValue
        humanNode3.physicsBody?.contactTestBitMask = bitMasks.ghost.rawValue
        humanNode3.name = "human3"
        bathRoomNode.addChild(humanNode3)
        scene.addChild(bathRoomNode)
        
        let workRoomNode = mapCreator.createWorkroom()
        let humanNode2 = SKSpriteNode(imageNamed: "human")
        humanNode2.size = CGSize(width: 48, height: 48)
        humanNode2.position = CGPoint(x: 0, y: 0)
        humanNode2.physicsBody = SKPhysicsBody(rectangleOf: humanNode2.size)
        humanNode2.physicsBody?.affectedByGravity = false
        humanNode2.physicsBody?.isDynamic = false
        humanNode2.physicsBody?.categoryBitMask = bitMasks.human.rawValue
        humanNode2.physicsBody?.collisionBitMask = bitMasks.ghost.rawValue
        humanNode2.physicsBody?.contactTestBitMask = bitMasks.ghost.rawValue
        humanNode2.name = "human2"
        workRoomNode.addChild(humanNode2)
        scene.addChild(workRoomNode)
        
        let bedRoomNode = mapCreator.createBedroom()
        let humanNode = SKSpriteNode(imageNamed: "human")
        humanNode.size = CGSize(width: 48, height: 48)
        humanNode.position = CGPoint(x: 0, y: 0)
        humanNode.physicsBody = SKPhysicsBody(rectangleOf: humanNode.size)
        humanNode.physicsBody?.affectedByGravity = false
        humanNode.physicsBody?.isDynamic = false
        humanNode.physicsBody?.categoryBitMask = bitMasks.human.rawValue
        humanNode.physicsBody?.collisionBitMask = bitMasks.ghost.rawValue
        humanNode.physicsBody?.contactTestBitMask = bitMasks.ghost.rawValue
        humanNode.name = "human"
        bedRoomNode.addChild(humanNode)
        scene.addChild(bedRoomNode)
        
        cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: 0.0, y: 0.0)
        scene.camera = cameraNode
        scene.addChild(cameraNode)
        
        let ghostNode = SKSpriteNode(imageNamed: "human")
        ghostNode.size = CGSize(width: 48, height: 48)
        ghostNode.position = CGPoint(x: 0.0, y: 0.0)
        ghostNode.physicsBody = SKPhysicsBody(rectangleOf: ghostNode.size)
        ghostNode.physicsBody?.affectedByGravity = false
        ghostNode.physicsBody?.isDynamic = true
        ghostNode.physicsBody?.categoryBitMask = bitMasks.ghost.rawValue
        ghostNode.physicsBody?.collisionBitMask = bitMasks.human.rawValue
        ghostNode.physicsBody?.contactTestBitMask = bitMasks.human.rawValue
        ghostNode.name = "ghost"
        scene.addChild(ghostNode)
       
        sceneView.presentScene(scene)
    }
    
    public override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscape
    }

    public override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
        return .landscapeLeft
    }
    
    private func addTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        sceneView.addGestureRecognizer(tapGestureRecognizer)
    }

    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        guard let scene = scene else { return }
        let location = gesture.location(in: sceneView)
        
        let cameraPosition = scene.camera?.position ?? CGPoint.zero
        let adjustedLocation = CGPoint(x: location.x + cameraPosition.x - screenSize.width / 2, y: screenSize.height - location.y + cameraPosition.y - screenSize.height / 2)
        
        
        if humanNodeTappable, let tappedNode = scene.atPoint(adjustedLocation) as? SKSpriteNode, tappedNode.name == "human" {
            presentSafeViewController()
            return
        }
        
        if humanNodeTappable2, let tappedNode = scene.atPoint(adjustedLocation) as? SKSpriteNode, tappedNode.name == "human2" {
            presentVentViewController()
            return
        }
        
        if humanNodeTappable3, let tappedNode = scene.atPoint(adjustedLocation) as? SKSpriteNode, tappedNode.name == "human3" {
            presentShadowViewController()
            return
        }
        
        if humanNodeTappable4, let tappedNode = scene.atPoint(adjustedLocation) as? SKSpriteNode, tappedNode.name == "human4" {
            presentDrawerViewController()
            return
        }
        
        if let ghostNode = scene.childNode(withName: "ghost") as? SKSpriteNode,
           let cameraNode = scene.camera {
            let newPosition = CGPoint(x: adjustedLocation.x , y: adjustedLocation.y )

            let moveTo = SKAction.move(to: newPosition, duration: 1.0)
            ghostNode.run(moveTo)
            cameraNode.run(moveTo)
        }
    }
    
    private func presentShadowViewController() {
        let shadowViewController = ShadowViewController()
        shadowViewController.modalPresentationStyle = .fullScreen
        present(shadowViewController, animated: true, completion: nil)
    }
    
    private func presentDrawerViewController() {
        let drawerViewController = DrawerViewController()
        drawerViewController.modalPresentationStyle = .fullScreen
        present(drawerViewController, animated: true, completion: nil)
    }
    
    private func presentSafeViewController() {
        let safeViewController = SafeViewController()
        safeViewController.modalPresentationStyle = .fullScreen
        present(safeViewController, animated: true, completion: nil)
    }
    
    private func presentVentViewController() {
        let ventViewController = VentViewController()
        ventViewController.modalPresentationStyle = .fullScreen
        present(ventViewController, animated: true, completion: nil)
    }

    public func didBegin(_ contact: SKPhysicsContact) {
       let contactA = contact.bodyA.node?.name
       let contactB = contact.bodyB.node?.name
       
       if (contactA == "ghost" && contactB == "human") || (contactA == "human" && contactB == "ghost") {
           humanNodeTappable = true
           print("tap humannya bro")
       }
        
        if (contactA == "ghost" && contactB == "human2") || (contactA == "human2" && contactB == "ghost") {
            humanNodeTappable2 = true
            print("tap humannya bro 2")
        }
        
        if (contactA == "ghost" && contactB == "human3") || (contactA == "human3" && contactB == "ghost") {
            humanNodeTappable3 = true
            print("tap humannya bro 3")
        }
        
        if (contactA == "ghost" && contactB == "human4") || (contactA == "human4" && contactB == "ghost") {
            humanNodeTappable4 = true
            print("tap humannya bro 4")
        }
    }
    
    public func didEnd(_ contact: SKPhysicsContact) {
       let contactA = contact.bodyA.node?.name
       let contactB = contact.bodyB.node?.name
       
       if (contactA == "ghost" && contactB == "human") || (contactA == "human" && contactB == "ghost") {
           humanNodeTappable = false
           print("tap humannya bro")
       }
        
        if (contactA == "ghost" && contactB == "human2") || (contactA == "human2" && contactB == "ghost") {
            humanNodeTappable2 = false
            print("tap humannya bro 2")
        }
        
        if (contactA == "ghost" && contactB == "human3") || (contactA == "human3" && contactB == "ghost") {
            humanNodeTappable3 = false
            print("tap humannya bro 3")
        }
        
        if (contactA == "ghost" && contactB == "human4") || (contactA == "human4" && contactB == "ghost") {
            humanNodeTappable4 = false
            print("tap humannya bro 4")
        }
    }
}
