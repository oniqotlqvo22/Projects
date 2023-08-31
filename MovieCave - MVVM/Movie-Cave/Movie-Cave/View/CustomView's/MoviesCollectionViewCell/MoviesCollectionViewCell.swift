//
//  MoviesCollectionViewCell.swift
//  Movie-Cave
//
//  Created by Admin on 30.08.23.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    static let identifier = "MoviesCollectionViewCell"
    
    private let starButton = UIButton(type: .custom)
    private let emptyStar = UIImage(systemName: "star")?.resizeImage(sizeChange: CGSize(width: 35, height: 35), tintColor: .systemYellow)
    private let filledStar = UIImage(systemName: "star.fill")?.resizeImage(sizeChange: CGSize(width: 35, height: 35), tintColor: .systemYellow)
    
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    var movieImage: UIImage? {
        didSet {
            imageView.image = movieImage
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        starButton.setImage(emptyStar, for: .normal)
        starButton.addTarget(self, action: #selector(toggleStar), for: .touchUpInside)
        self.clipsToBounds = true
        
        if getUser.filip.isLogedIn {
            self.contentView.addSubview(starButton)
        }
        
        starButton.frame = CGRect(x: 1, y: 1, width: 40, height: 40)
        
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
    
    @objc func toggleStar(_ sender: UIButton) {
        sender.currentImage == emptyStar
        ? sender.setImage(filledStar, for: .normal)
        : sender.setImage(emptyStar, for: .normal)
    }
    
}
