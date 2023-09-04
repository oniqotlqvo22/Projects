//
//  MoviesCollectionViewCell.swift
//  Movie-Cave
//
//  Created by Admin on 30.08.23.
//

import UIKit

protocol MoviesCollectionViewCellDelegate: AnyObject {
    func didTapButton(in cell: MoviesCollectionViewCell, for movie: Movie)
}

class MoviesCollectionViewCell: UICollectionViewCell {

    static let identifier = "MoviesCollectionViewCell"
    private var favoriteButton: UIButton!
    private let emptyStar = UIImage(systemName: "star")?.resizeImage(sizeChange: CGSize(width: 35, height: 35), tintColor: .systemYellow)
    private let filledStar = UIImage(systemName: "star.fill")?.resizeImage(sizeChange: CGSize(width: 35, height: 35), tintColor: .systemYellow)
    
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var movie: Movie? {
        didSet {
            guard let movie else { return }
            
            movie.favorite
            ? favoriteButton.setImage(filledStar, for: .normal)
            : favoriteButton.setImage(emptyStar, for: .normal)
            
            imageView.image = movie.image
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
        
        favoriteButton = UIButton(frame: CGRect(x:1, y:1, width:40,height:40))
        self.addSubview(favoriteButton)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
//        imageView.image = nil
    }
    
}
