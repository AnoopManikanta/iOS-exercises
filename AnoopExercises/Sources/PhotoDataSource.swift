//
//  PhotoDataSource.swift
//  AnoopExercises
//
//  Created by Anoop Subramani on 17/02/22.
//

import UIKit

class PhotoDataSource: NSObject {
    // MARK: - Variable

    var photos = [Photo]()
}

// MARK: - Collection View Data Source

extension PhotoDataSource: UICollectionViewDataSource {
    // number of items in a section
    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return photos.count
    }

    // cell for each item, display spinner at the beginning as there is nothing to view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = PhotoCollectionViewCell.cellIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotoCollectionViewCell

        let photo = photos[indexPath.row]
        cell.photoDescription = photo.title
        cell.update(displaying: nil)
        return cell
    }
}
