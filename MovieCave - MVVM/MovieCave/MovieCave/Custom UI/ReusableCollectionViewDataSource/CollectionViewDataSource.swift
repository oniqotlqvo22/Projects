//
//  MediaCollectionView.swift
//  MovieCave
//
//  Created by Admin on 30.12.23.
//

import UIKit

class CollectionViewDataSource<T>: NSObject, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: - Properties
    var items: [T]
    var configureCell: ((CollectionViewReusableCell, IndexPath, T) -> Void)?
    var didSelectItem: ((T) -> Void)?
    var changePageHandler: (() -> Void)?
    var resetToFirstPageHandler: (() -> Void)?

    //MARK: - Initialization
    init(items: [T]) {
        self.items = items
    }
    
    // MARK: - UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.MoviesCollectionCellidentifier, for: indexPath) as? CollectionViewReusableCell else {
            return UICollectionViewCell()
        }
        
        let items = items[indexPath.item]
        configureCell?(cell,indexPath, items)
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = items[indexPath.item]
        didSelectItem?(item)
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 8
        let numberOfItemsPerRow: CGFloat = 2
        let totalSpacing: CGFloat = (numberOfItemsPerRow - 1) * spacing
        let width = (collectionView.frame.width - totalSpacing) / numberOfItemsPerRow
        let height = width * 1.5
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            changePageHandler?()
        } else if offsetY * -1 > offsetY {
            resetToFirstPageHandler?()
        }
    }
}
