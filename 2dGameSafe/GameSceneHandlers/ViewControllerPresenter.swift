//
//  ViewControllerPresenter.swift
//  2dGameSafe
//
//  Created by Hansen Yudistira on 24/06/24.
//

import UIKit
import SpriteKit

class ViewControllerPresenter {
    weak var presentingViewController: UIViewController?

    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }

    func presentShadowViewController() {
        let shadowViewController = ShadowViewController()
        shadowViewController.modalPresentationStyle = .fullScreen
        presentingViewController?.present(shadowViewController, animated: true, completion: nil)
    }

    func presentDrawerViewController() {
        let drawerViewController = DrawerViewController()
        drawerViewController.modalPresentationStyle = .fullScreen
        presentingViewController?.present(drawerViewController, animated: true, completion: nil)
    }

    func presentSafeViewController() {
        let safeViewController = SafeViewController()
        safeViewController.modalPresentationStyle = .fullScreen
        presentingViewController?.present(safeViewController, animated: true, completion: nil)
    }

    func presentVentViewController() {
        let ventViewController = VentViewController()
        ventViewController.modalPresentationStyle = .fullScreen
        presentingViewController?.present(ventViewController, animated: true, completion: nil)
    }
}

extension SKScene {
    func viewController() -> UIViewController? {
        var responder: UIResponder? = self.view
        while responder != nil {
            responder = responder!.next
            if let viewController = responder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
