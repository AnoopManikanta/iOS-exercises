//
//  PhotoInfoViewController.swift
//  AnoopExercises
//
//  Created by Anoop Subramani on 17/02/22.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    // MARK: - Views

    private weak var imageView: UIImageView!

    // MARK: - Variables

    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }

    var store: PhotoStore!

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let constraints = setupImageView()
        NSLayoutConstraint.activate(constraints)

        fetchImage()
    }

    // MARK: - Setup

    private func setupImageView() -> [NSLayoutConstraint] {
        let imageView = UIImageView()
        imageView.configureView { iV in
            iV.contentMode = .scaleAspectFit
        }
        self.imageView = imageView
        self.imageView.accessibilityLabel = photo.title
        view.addSubview(self.imageView)

        let safeArea = view.safeAreaLayoutGuide
        return [
            self.imageView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.imageView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            self.imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ]
    }

    private func fetchImage() {
        store.fetchImage(for: photo) { result in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
}
