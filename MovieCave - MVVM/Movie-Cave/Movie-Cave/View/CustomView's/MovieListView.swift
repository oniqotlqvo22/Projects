//
//  MovieListView.swift
//  Movie-Cave
//
//  Created by Admin on 30.08.23.
//

import UIKit

extension UIImage {
    func resizeImage(sizeChange: CGSize, tintColor: UIColor) -> UIImage {
      UIGraphicsBeginImageContextWithOptions(sizeChange, false, 0)
      tintColor.set() // set tint color
      draw(in: CGRect(origin: .zero, size: sizeChange))
      let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
      UIGraphicsEndImageContext()
      resizedImage.withRenderingMode(.alwaysTemplate)

        return resizedImage.withTintColor(tintColor)

    }
    
}

class MovieListView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet private weak var collectionView: UICollectionView!

    let starButton = UIButton(type: .custom)
    let emptyStar = UIImage(systemName: "star")?.resizeImage(sizeChange: CGSize(width: 35, height: 35), tintColor: .systemYellow)
    let filledStar = UIImage(systemName: "star.fill")?.resizeImage(sizeChange: CGSize(width: 35, height: 35), tintColor: .systemYellow)
//    let filledStar = UIImage(systemName: "star.fill")?.withColor(.systemYellow, sizeChange: CGSize(width: 45, height: 45))
//    let emptyStar = UIImage(systemName: "star")?.withColor(.systemYellow, sizeChange: CGSize(width: 45, height: 45))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        collectionView.register(MoviesCollectionViewCell.self,
                                forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self

        emptyStar?.withRenderingMode(.alwaysTemplate)
        filledStar?.withRenderingMode(.alwaysTemplate)

        starButton.setImage(emptyStar, for: .normal)
        starButton.addTarget(self, action: #selector(toggleStar), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        collectionView.register(MoviesCollectionViewCell.self,
                                forCellWithReuseIdentifier: MoviesCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        emptyStar?.withRenderingMode(.alwaysTemplate)
        filledStar?.withRenderingMode(.alwaysTemplate)
        
        starButton.setImage(emptyStar, for: .normal)
        starButton.addTarget(self, action: #selector(toggleStar), for: .touchUpInside)
    }
    
    private func configureView() {
        guard let view = self.loadViewFromNib(nibName: "MovieListView") else { return }
        
        view.frame = self.bounds
        self.addSubview(view)
    }
    
    @objc func toggleStar(_ sender: UIButton) {
        if sender.currentImage == emptyStar {
          sender.setImage(filledStar, for: .normal)
        } else {
          sender.setImage(emptyStar, for: .normal)
        }
    }

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesCollectionViewCell.identifier,
                                                      for: indexPath)
    
        cell.clipsToBounds = true
        cell.contentView.addSubview(starButton)
        starButton.frame = CGRect(x: 1, y: 1, width: 40, height: 40)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.frame.width / 2) - 1,
                      height: (self.frame.width / 2) - 1)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("\(indexPath.row)")
    }
    
    
}
