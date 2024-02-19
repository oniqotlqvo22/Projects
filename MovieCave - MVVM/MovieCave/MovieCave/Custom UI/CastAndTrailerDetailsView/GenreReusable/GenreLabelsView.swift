//
//  GenresView.swift
//  MovieCave
//
//  Created by Admin on 13.01.24.
//

import UIKit

protocol GenreLabelsViewProtocol: UIView {
    
    /// Sets up genre labels based on the provided genres.
    /// - Parameter genres: An array of strings representing the genres.
    func setUpGenreLabels(with genres: [String])
}

class GenreLabelsView: UIView, GenreLabelsViewProtocol {
    
    //MARK: - Properties
    private var genreLabels: [GenreView] = []
    
    //MARK: - Public Methods
    func setUpGenreLabels(with genres: [String]) {
        removeAllGenreLabels()
        
        var xPosition: CGFloat = Constants.genreLabelXposition
        var yPosition: CGFloat = Constants.genreLabelYposition
        var row = Constants.genreLabelStartingRowPosition
        var currentRowHighestElement: CGFloat = Constants.genreLabelStartingRowHighestElement
        
        genres.forEach { genre in
            let genreLabel = GenreView(text: genre)
            
            if genreLabel.frame.size.height > currentRowHighestElement {
                currentRowHighestElement = genreLabel.frame.size.height
            }
            
            if genreLabel.frame.width >= frame.size.width - xPosition {
                row += Constants.genreLabelRowPlus
                yPosition += currentRowHighestElement + Constants.additionalYposicitonSpacing
                xPosition = Constants.genreLabelXposition
                currentRowHighestElement = Constants.genreLabelStartingRowHighestElement
            }
            
            genreLabel.frame.origin = CGPoint(x: xPosition, y: yPosition + Constants.genreLabelAdditionalFrameOriginY)
            
            addSubview(genreLabel)
            genreLabels.append(genreLabel)
            
            xPosition += genreLabel.frame.size.width + Constants.additionalXpositionSizeWidth
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

