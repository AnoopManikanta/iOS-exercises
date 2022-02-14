//
// Copyright © 2022 Surya Software Systems Pvt. Ltd.
//

import UIKit

extension UIWindow {
    // Remove this comment if using default navigation
    func setupRootViewController(with viewController: UIViewController) {
        // create a new navigation controller
        let itemStore = ItemStore()
        let navigationController = UINavigationController()
        let viewController = ViewController()
        viewController.itemStore = itemStore
        navigationController.viewControllers = [viewController]
        // Set the initial View Controller to our instance of ViewController
        rootViewController = navigationController
        // Present the window
        makeKeyAndVisible()
    }
}
