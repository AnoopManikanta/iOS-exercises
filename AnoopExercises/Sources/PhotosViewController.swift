//
// Copyright © 2022 Surya Software Systems Pvt. Ltd.
//

import UIKit

class PhotosViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView! = {
        // layout to support scrolling in a particular axis with set cell parameters 
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 90, height: 90)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: "cvCell")
        return cv
    } ()
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activateConstraints()
        collectionView.delegate = self
        collectionView.dataSource = photoDataSource
        
        // add list of photos
        self.store.fetchInterestingPhotos{ (photosResult) in
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
    
    private func activateConstraints() {
        view.backgroundColor = .white
        navigationItem.title = "Photorama"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor)
        ])
    }
}

extension PhotosViewController: UICollectionViewDelegate{
    
    // display images at each cell
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        // Download the image data
        store.fetchImage(for: photo){ (result) in
            // fetch latest index for the photo, as it might change in the process
            guard let photoIndex = self.photoDataSource.photos.firstIndex(of: photo),
                    case let .success(image) = result else {
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first{
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
