//
// Copyright © 2022 Surya Software Systems Pvt. Ltd.
//

import UIKit


extension UIWindow {
//    Uncomment the following function if using TabBarController and remove the exiting `setupRootViewController` function
    func setupRootViewController() {
        // Create new Tab Bar Controller
        let tabBarController = UITabBarController()
        // Add view controllers to TabBarController
        tabBarController.viewControllers = [
            embedInNavController(ViewController(), title: "Conversion"),
            embedInNavController(MapViewController(), title: "Map")
        ]
        rootViewController = tabBarController

        makeKeyAndVisible()
    }
}

// Uncomment the following if using TabBarController
private func embedInNavController(_ viewController: UIViewController, title: String) -> UINavigationController {
    let navigationController = UINavigationController(rootViewController: viewController)
    viewController.title = title
    return navigationController
 }
