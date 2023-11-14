//
//  MovieCastAndTrailerDetailsView.swift
//  Movie-Cave
//
//  Created by Admin on 6.09.23.
//

import UIKit

class MovieCastAndTrailerDetailsView: UIView {
    
    //MARK: - Properties
    let imageView = UIImageView()
    let label = UILabel()
    var wantCircularImage = false
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Override Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        guard wantCircularImage else { return }

        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3.0
        imageView.layer.borderColor = UIColor.opaqueSeparator.cgColor
    }

}
