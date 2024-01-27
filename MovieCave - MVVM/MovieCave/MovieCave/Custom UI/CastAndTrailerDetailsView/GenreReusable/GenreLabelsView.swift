//
//  GenresView.swift
//  MovieCave
//
//  Created by Admin on 13.01.24.
//

import UIKit

class GenreLabelsView: UIView {
    
    //MARK: - Properties
    private var genreLabels = [GenreView]()
    
    //MARK: - Public Methods
    func setUpGenreLabels(with genres: [String]) {
        removeAllGenreLabels()
        
        var xPosition: CGFloat = 8
        var yPosition: CGFloat = 0
        var row = 0
        var currentRowHighestElement: CGFloat = 0
        
        for genre in genres {
            let genreLabel = GenreView(text: genre)
            
            if genreLabel.frame.size.height > currentRowHighestElement {
                currentRowHighestElement = genreLabel.frame.size.height
            }
            
            if genreLabel.frame.width >= frame.size.width - xPosition {
                row += 1
                yPosition += currentRowHighestElement + 32
                xPosition = 8
                currentRowHighestElement = 0
            }
            
            genreLabel.frame.origin = CGPoint(x: xPosition, y: yPosition + 16)
            
            addSubview(genreLabel)
            genreLabels.append(genreLabel)
            
            xPosition += genreLabel.frame.size.width + 16
        }
    }
    
    //MARK: - Private
    private func removeAllGenreLabels() {
        for genreLabel in genreLabels {
            genreLabel.removeFromSuperview()
        }

        genreLabels.removeAll()
    }
}

