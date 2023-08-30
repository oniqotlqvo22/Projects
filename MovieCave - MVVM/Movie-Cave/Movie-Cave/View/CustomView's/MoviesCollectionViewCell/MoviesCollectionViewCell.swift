//
//  MoviesCollectionViewCell.swift
//  Movie-Cave
//
//  Created by Admin on 30.08.23.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {

    static let identifier = "MoviesCollectionViewCell"
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
        let images: [UIImage] = [
            UIImage(named: "parasite"),
            UIImage(named: "oppenheimer"),
            UIImage(named: "guardians"),
            UIImage(named: "ruronin"),
            UIImage(named: "dune"),
            UIImage(named: "yasuke")
        ].compactMap({ $0 })
        
        imageView.image = images.randomElement()
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
