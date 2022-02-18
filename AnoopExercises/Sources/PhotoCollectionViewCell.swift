//
//  PhotoCollectionViewCell.swift
//  AnoopExercises
//
//  Created by Anoop Subramani on 17/02/22.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    // MARK: - Views

    private weak var imageView: UIImageView!
    private weak var spinner: UIActivityIndicatorView!

    // MARK: - Variables

    static let cellIdentifier = "PhotoCell"
    var photoDescription: String?
    override var accessibilityLabel: String? {
        get {
            return photoDescription
        }
        set {}
    }

    override var accessibilityTraits: UIAccessibilityTraits {
        get {
            return super.accessibilityTraits.union([.image, .button])
        }
        set {}
    }

    override var isAccessibilityElement: Bool {
        get {
            return true
        }
        set {}
    }

    // MARK: - Cell Update

    // if image is present then display the image, else activate spinner animation
    func update(displaying image: UIImage?) {
        var constraints = setupImageView()
        constraints += setupSpinner()
        NSLayoutConstraint.activate(constraints)

        if let imageToDisplay = image {
            spinner.stopAnimating()
            imageView.image = imageToDisplay
        } else {
            spinner.startAnimating()
            imageView.image = nil
        }
    }

    // MARK: - Setup

    private func setupImageView() -> [NSLayoutConstraint] {
        let imageView = UIImageView()
        imageView.configureView { iV in
            iV.contentMode = .scaleToFill
        }
        self.imageView = imageView
        addSubview(self.imageView)

        return [
            imageView.widthAnchor.constraint(equalTo: widthAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor),
        ]
    }

    private func setupSpinner() -> [NSLayoutConstraint] {
        let spinner = UIActivityIndicatorView()
        spinner.configureView { s in
            s.color = .white
        }
        self.spinner = spinner
        addSubview(self.spinner)

        return [
            spinner.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
        ]
    }
}
