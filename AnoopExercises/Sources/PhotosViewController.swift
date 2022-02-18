//
// Copyright © 2022 Surya Software Systems Pvt. Ltd.
//

import UIKit

class PhotosViewController: UIViewController {
    // MARK: - views

    private weak var collectionView: UICollectionView!

    // MARK: - variables

    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = R.string.localizable.rootViewTitle()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: R.string.localizable.backButton(), style: .plain, target: nil, action: nil)

        let constraints = setupCollectionView()
        NSLayoutConstraint.activate(constraints)

        // add list of photos
        fetchPhotos()
    }

    // MARK: - Setup

    private func setupCollectionView() -> [NSLayoutConstraint] {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 90, height: 90)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)

        let collecitonView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collecitonView.configureView { cv in
            cv.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.cellIdentifier)
            cv.delegate = self
            cv.dataSource = photoDataSource
        }
        self.collectionView = collecitonView

        view.addSubview(self.collectionView)
        let safeArea = view.safeAreaLayoutGuide

        return [
            self.collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            self.collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            self.collectionView.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
        ]
    }

    private func fetchPhotos() {
        store.fetchInterestingPhotos { photosResult in
            switch photosResult {
            case let .success(photos):
                print("Successfully found \(photos.count) photos")
                self.photoDataSource.photos = photos
            case let .failure(error):
                print("Error fetching interesting photos: \(error)")
                // upon failure, clear the list
                self.photoDataSource.photos.removeAll()
            }
            // refresh the view to see the result
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
}

// MARK: - Collection View Delegate

extension PhotosViewController: UICollectionViewDelegate {
    // display images at each cell
    func collectionView(_: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]

        // Download the image data
        store.fetchImage(for: photo) { result in
            // fetch latest index for the photo, as it might change in the process
            guard let photoIndex = self.photoDataSource.photos.firstIndex(of: photo),
                case let .success(image) = result
            else {
                return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)

            // when the request finishes, find the current cell for this photo
            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                cell.update(displaying: image)
            }
        }
    }

    // on selecting an item, push new vc with respective data to the navigation controller
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt _: IndexPath) {
        if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
            let photo = photoDataSource.photos[selectedIndexPath.row]
            let destinationVC = PhotoInfoViewController()
            destinationVC.photo = photo
            destinationVC.store = store
            navigationController?.pushViewController(destinationVC, animated: true)
        } else {
            preconditionFailure("Unexpected Destination")
        }
    }
}
