//
//  CollectionViewCell.swift
//  MovieCave
//
//  Created by Admin on 28.09.23.
//

import UIKit

class CollectionViewReusableCell: UICollectionViewCell {

    //MARK: - Properties
    private var favoriteButton: UIButton!
    private let emptyStar = UIImage(systemName: Constants.starImage)?
        .resizeSystemImage(sizeChange: CGSize(width: Constants.systemIconWidht, height: Constants.systemIconHeight), tintColor: .systemYellow)
    private let filledStar = UIImage(systemName: Constants.starFillImage)?
        .resizeSystemImage(sizeChange: CGSize(width: Constants.systemIconWidht, height: Constants.systemIconHeight), tintColor: .systemYellow)
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    var tvSeries: TVSeriesResults? {
        didSet {
            guard let tvSeries else { return }
            
            imageView.downloaded(from: Constants.moviePosterURL + (tvSeries.posterPath ?? Constants.noImageString), contentMode: .scaleAspectFit)
        }
    }
    
    var movie: MoviesModel? {
        didSet {
            guard let movie else { return }
            
            favortieStarButtonChange(movie: movie)
            imageView.downloaded(from: Constants.moviePosterURL + (movie.movieResults.posterPath ?? Constants.noImageString), contentMode: .scaleAspectFit)
        }
    }

    //MARK: - Initiaizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        contentView.addSubview(imageView)
        contentView.clipsToBounds = true
        
        favoriteButton = UIButton(frame: CGRect(x:1, y:1, width:35,height:35))
        self.addSubview(favoriteButton)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Override Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    private func favortieStarButtonChange(movie: MoviesModel) {
        DispatchQueue.main.async {
            movie.isFavorite
            ? self.favoriteButton.setImage(self.filledStar, for: .normal)
            : self.favoriteButton.setImage(self.emptyStar, for: .normal)
        }
    }
    
}
