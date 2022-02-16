//
//  UIImage+Mandala.swift
//  AnoopExercises
//
//  Created by Anoop Subramani on 15/02/22.
//

import UIKit

enum ImageResource: String {
    case angry
    case confused
    case crying
    case goofy
    case happy
    case meh
    case sad
    case sleepy
}

extension UIImage {
    convenience init(resource: ImageResource){
        self.init(named: resource.rawValue)!
    }
}
