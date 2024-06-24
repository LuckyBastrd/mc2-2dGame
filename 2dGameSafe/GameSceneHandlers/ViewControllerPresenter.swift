//
//  ViewControllerPresenter.swift
//  2dGameSafe
//
//  Created by Hansen Yudistira on 24/06/24.
//

import UIKit
import SpriteKit

enum ViewControllerType {
    case shadow
    case drawer
    case safe
    case vent
}

class ViewControllerPresenter {
    weak var presentingViewController: UIViewController?

    init(presentingViewController: UIViewController) {
        self.presentingViewController = presentingViewController
    }

    func present(viewControllerType: ViewControllerType) {
        let viewController: UIViewController

        switch viewControllerType {
        case .shadow:
            viewController = ShadowViewController()
        case .drawer:
            viewController = DrawerViewController()
        case .safe:
            viewController = SafeViewController()
        case .vent:
            viewController = VentViewController()
        }

        viewController.modalPresentationStyle = .fullScreen
        presentingViewController?.present(viewController, animated: true, completion: nil)
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
