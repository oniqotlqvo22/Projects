//
//  TrailerVideosView.swift
//  MovieCave
//
//  Created by Admin on 13.01.24.
//

import UIKit

class TrailerVideosView: UIStackView{
    
    //MARK: - Properties
    private var trailerViews = [TrailerView]()
    
    //MARK: - Public Methods
    func setUpTrailers(with trailers: [MediaVideos], trailerViewDelegate: TrailerViewDelegate) {
        self.spacing = 8
        for video in trailers {
            let trailerView = TrailerView()
            trailerView.configureView(videoKey: video.key, labelText: video.name, widthAnchorConst: 120)
            trailerView.delegate = trailerViewDelegate
            addArrangedSubview(trailerView)
        }
    }
    
    //MARK: - Private
    private func removeAllTrailers() {
        for genreLabel in trailerViews {
            genreLabel.removeFromSuperview()
        }

        trailerViews.removeAll()
    }
}
