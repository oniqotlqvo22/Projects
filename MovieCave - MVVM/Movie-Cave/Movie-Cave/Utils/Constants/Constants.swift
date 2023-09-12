//
//  Constants.swift
//  Movie-Cave
//
//  Created by Admin on 11.09.23.
//

import Foundation
import UIKit

//MARK: - Constants
struct Constants {
    
    static let movieListNibName = "MovieListView"
    static let navigationViewNibName = "NavigationView"
    static let filterBarViewNibName = "FilterBarView"
    
    static let moviesNavigationButton = "Movies"
    static let addMovieNavigationButton = "Add Movie"
    static let profileNavigationButton = "Profile"
    
    static let mostPopularFilterButton = "Most popular"
    static let longestFilterButton = "Longest"
    static let ratingFilterButton = "Rating"
    static let newestFilterButton = "Newest"
    
    static let filterButtonsHighLightColor: UIColor = UIColor(red: 0.45, green: 0.20, blue: 0.25, alpha: 0.65)
    static let searchBarPlaceHolder = "Search"
    static let MoviesCollectionCellidentifier = "MoviesCollectionViewCell"
    static let systemIconWidht: CGFloat = 35
    static let systemIconHeight: CGFloat = 35
    
    static let genreChoseArray: [String] = [
        "Action", "Adventure", "Animation", "Comedy", "Crime", "Documentary", "Drama", "Family", "Fantasy", "Crime"
    ]
    
    static let favoriteButtonWidth: CGFloat = 40
    static let favoriteButtonHeight: CGFloat = 40
}
