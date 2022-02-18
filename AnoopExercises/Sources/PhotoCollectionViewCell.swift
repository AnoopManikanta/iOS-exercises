//
//  PhotoCollectionViewCell.swift
//  AnoopExercises
//
//  Created by Anoop Subramani on 17/02/22.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView! = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleToFill
        return image
    } ()
    
    @IBOutlet var spinner: UIActivityIndicatorView! = {
        let spinner = UIActivityIndicatorView()
        spinner.color = .white
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    } ()
    
    var photoDescription: String?
    override var accessibilityLabel: String? {
        get {
            return photoDescription
        }
        set {
            //ignore
        }
    }
    
    override var accessibilityTraits: UIAccessibilityTraits {
        get {
            return super.accessibilityTraits.union([.image, .button])
        }
        set {
            // Ignore
        }
    }

    override var isAccessibilityElement: Bool {
        get {
            return true
        }
        set {
            // ignore
        }
    }
    
    private func activateConstraints() {
        self.addSubview(imageView)
        self.addSubview(spinner)
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor),
            spinner.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
    
    // if image is present then display the image, else activate spinner animation
    func update(displaying image: UIImage?) {
        activateConstraints()
        if let imageToDisplay = image {
            spinner.stopAnimating()
            imageView.image = imageToDisplay
            
        } else {
            spinner.startAnimating()
            imageView.image = nil
        }
    }
}
