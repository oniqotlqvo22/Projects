//
//  PopulatedCastView.swift
//  MovieCave
//
//  Created by Admin on 13.01.24.
//

import UIKit

class PopulatedCastView: UIStackView {
    
    //MARK: - Properties
    private var castViews = [TrailerView]()
    
    //MARK: - Public Methods
    func setUpCast(with cast: [MediaCast]) {
        self.spacing = 8
        for actor in cast {
            guard let castPoster = actor.poster else { return }
            
            let cast = CastView()
            cast.configureView(with: 70, posterKey: castPoster, castName: actor.name)
            addArrangedSubview(cast)
        }
    }
    
    //MARK: - Private
    private func removeAllCast() {
        for genreLabel in castViews {
            genreLabel.removeFromSuperview()
        }

        castViews.removeAll()
    }
}
