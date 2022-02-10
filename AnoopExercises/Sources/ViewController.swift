//
// Copyright © 2022 Surya Software Systems Pvt. Ltd.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = nil
        let conversionView = ConversionView()
        conversionView.frame = view.frame
        view.addSubview(conversionView)
        conversionView.updateCelsius()
    }
}
