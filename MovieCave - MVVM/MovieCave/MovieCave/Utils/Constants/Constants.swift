//
//  Constants.swift
//  MovieCave
//
//  Created by Admin on 28.09.23.
//

import Foundation
import UIKit

//MARK: - Constants
struct Constants {
    
    static let noImageString = "no image"
    static let popUpViewNibName = "PopUpView"
    static let reusableViewNibName = "ReusableView"
    static let trailerKeyWord = "Trailer"
    static let playButtonImage = "play-button"
    static let starImage = "star"
    static let starFillImage = "star.fill"
    
    static let loginCoordinatorID = "loginCoordinator"
    static let tabBarCoordinatorID = "tabBarCoordinator"
    static let moviesViewCoordinatorID = "moviesViewCoordinator"
    static let tvSeriesViewCoordinatorID = "tvSeriesCoordinator"
    static let profileViewCoordinatorID = "profileViewCoordinator"
    static let movieDetailsCoordinatorID = "movieDetailsCoordinator"
    static let tvSeriesDetailsCoordinatorID = "tvSeriesDetailsCoordinator"
    static let personalInfoCoordinatorID = "personalInfoCoordinator"
    
    static let profileNavBarTitle = "Profile"
    
    static let movieListNibName = "MovieListView"
    static let navigationViewNibName = "NavigationView"
    static let filterBarViewNibName = "FilterBarView"
    
    static let moviesNavigationButton = "Movies"
    static let addMovieNavigationButton = "Add Movie"
    static let profileNavigationButton = "Profile"
    
    static let popularTVSeriesFilterButton = "Most popular"
    static let airingTodayTVSeriesFilterButton = "Airing today"
    static let onTheAirTVSeriesFilterButton = "On the air"
    static let topRatedTVSeriesFilterButton = "Top rated"
    
    static let mostPopularFilterButton = "Most popular"
    static let upComingFilterButton = "Upcoming"
    static let ratingFilterButton = "Top rated"
    static let newestFilterButton = "Newest"
    
    static let filterButtonsHighLightColor: UIColor = UIColor(red: 0.10, green: 0.25, blue: 0.56, alpha: 0.65)
    static let searchBarPlaceHolder = "Search"
    static let MoviesCollectionCellidentifier = "MoviesCollectionViewCell"
    static let systemIconWidht: CGFloat = 35
    static let systemIconHeight: CGFloat = 35
    
    static let moviePosterURL: String = "https://image.tmdb.org/t/p/w500"
    static let genreChoseArray: [String] = [
        "Action", "Adventure", "Animation", "Comedy", "Crime", "Documentary", "Drama", "Family", "Fantasy", "Crime"
    ]
    
    static let favoriteButtonWidth: CGFloat = 40
    static let favoriteButtonHeight: CGFloat = 40
}

