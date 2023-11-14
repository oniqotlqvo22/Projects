//
//  MoviesCollectionViewCell.swift
//  Movie-Cave
//
//  Created by Admin on 30.08.23.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    //MARK: - Properties
    private var favoriteButton: UIButton!
    private let emptyStar = UIImage(systemName: "star")?
        .resizeSystemImage(sizeChange: CGSize(width: Constants.systemIconWidht, height: Constants.systemIconHeight), tintColor: .systemYellow)
    private let filledStar = UIImage(systemName: "star.fill")?
        .resizeSystemImage(sizeChange: CGSize(width: Constants.systemIconWidht, height: Constants.systemIconHeight), tintColor: .systemYellow)
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    var movie: MovieData? {
        didSet {
            guard let movie else { return }
            
            movie.favorite
            ? favoriteButton.setImage(filledStar, for: .normal)
            : favoriteButton.setImage(emptyStar, for: .normal)
            
            imageView.image = UIImage().loadImageFromDocumentsDirectory(withName: movie.imageName ?? "")
        }
    }

    //MARK: - Initiaizers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.borderWidth = 2
        self.layer.borderColor = CGColor(red: 0.45, green: 0.20, blue: 0.25, alpha: 0.64)
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
    }
    
}
