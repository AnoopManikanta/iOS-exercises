//
// Copyright © 2022 Surya Software Systems Pvt. Ltd.
//

import UIKit

extension UIWindow {
    // Remove this comment if using default navigation
    func setupRootViewController(with viewController: UIViewController) {
        //
        // Set the initial View Controller to our instance of ViewController
        rootViewController = viewController
        //
        // Present the window
        makeKeyAndVisible()
    }
}
