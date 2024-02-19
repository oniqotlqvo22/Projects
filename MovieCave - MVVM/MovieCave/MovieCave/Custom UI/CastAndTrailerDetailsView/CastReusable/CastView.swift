//
//  CastView.swift
//  MovieCave
//
//  Created by Admin on 30.12.23.
//

import UIKit

protocol CastViewProtocol: AnyObject {
    /// Configures the view with a width constraint, poster image key, and cast member name.
    /// - Parameters:
    ///   - widhtConstraint: The constraint to use for the view's width.
    ///   - posterKey: The image key to use for the cast member's poster.
    ///   - castName: The name of the cast member to display.
    func configureView(with widhtConstraint: CGFloat, posterKey: String, castName: String)
}

class CastView: UIView, CastViewProtocol {
    
    //MARK: - Properties
    private let imageView = UIImageView()
    private let label = UILabel()
    
    //MARK: - CastViewProtocol
    func configureView(with widhtConstraint: CGFloat, posterKey: String, castName: String) {
        setUpView(widthAnchorConst: widhtConstraint)
        setUpImageView(for: posterKey)
        setUpLabel(for: castName)
    }
    
    //MARK: - Private
    private func setUpView(widthAnchorConst: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.masksToBounds = true
        widthAnchor.constraint(equalToConstant: widthAnchorConst).isActive = true
        addSubview(label)
        addSubview(imageView)
    }
    
    private func setUpImageView(for posterKey: String) {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: Constants.castImageViewHeightAnchor).isActive = true
        imageView.layer.borderWidth = Constants.imageViewLayerBorderWidth
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.downloaded(from: Constants.moviePosterURL + posterKey)
    }
    
    private func setUpLabel(for castName: String) {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: Constants.labelHeightAnchor).isActive = true
        label.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        label.numberOfLines = Constants.labelNumberOfLinesZero
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.textColor = .white
        label.text = castName
    }
    
    //MARK: - Override Methods
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.size.width / Constants.cornerRadiusDevider
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.opaqueSeparator.cgColor
    }
}
