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
    
    //MARK: - Media Details constants
    static let noMorePages = "This is the end my friend"
    static let noImageString = "no image"
    static let popUpViewNibName = "PopUpView"
    static let reusableViewNibName = "ReusableView"
    static let trailerKeyWord = "Trailer"
    static let playButtonImage = "play-button"
    static let starImage = "star"
    static let starFillImage = "star.fill"
    
    //MARK: - Coordinators constants
    static let userWellcomeMessage = "Hello User"
    static let loginCoordinatorID = "loginCoordinator"
    static let tabBarCoordinatorID = "tabBarCoordinator"
    static let moviesViewCoordinatorID = "moviesViewCoordinator"
    static let tvSeriesViewCoordinatorID = "tvSeriesCoordinator"
    static let profileViewCoordinatorID = "profileViewCoordinator"
    static let movieDetailsCoordinatorID = "movieDetailsCoordinator"
    static let tvSeriesDetailsCoordinatorID = "tvSeriesDetailsCoordinator"
    static let personalInfoCoordinatorID = "personalInfoCoordinator"
    static let profileNavBarTitle = "Profile"
    
    //MARK: - Nib files constants
    static let movieListNibName = "MovieListView"
    static let navigationViewNibName = "NavigationView"
    static let filterBarViewNibName = "FilterBarView"
    static let moviesNavigationButton = "Movies"
    static let addMovieNavigationButton = "Add Movie"
    static let profileNavigationButton = "Profile"
    
    //MARK: - TV Series filter button constants
    static let popularTVSeriesFilterButton = "Most popular"
    static let airingTodayTVSeriesFilterButton = "Airing today"
    static let onTheAirTVSeriesFilterButton = "On the air"
    static let topRatedTVSeriesFilterButton = "Top rated"
    
    //MARK: - Movie filter button constants
    static let mostPopularFilterButton = "Most popular"
    static let upComingFilterButton = "Upcoming"
    static let ratingFilterButton = "Top rated"
    static let newestFilterButton = "Newest"
    
    //MARK: - ReusableListView
    static let stackViewTrailingAnchorConstraint: CGFloat = -8
    static let stackViewLeadingAnchorConstraint: CGFloat = 8
    static let filterButtonTitleLabelFontSize: CGFloat = 16
    static let filterButtonLayerCornerRadius: CGFloat = 5
    static let filterButtonHeightAnchorConstraint: CGFloat = 25
    static let reusableListViewStackViewSpacing: CGFloat = 8
    static let reusableListViewSearchTextDebounce: Int = 500
    static let filterButtonsHighLightColor: UIColor = UIColor(red: 0.10, green: 0.25, blue: 0.56, alpha: 0.65)
    static let searchBarPlaceHolder = "Search"
    static let MoviesCollectionCellidentifier = "MoviesCollectionViewCell"
    static let systemIconWidht: CGFloat = 35
    static let systemIconHeight: CGFloat = 35
    static let moviePosterURL: String = "https://image.tmdb.org/t/p/w500"
    
    //MARK: - BubblyLabel
    static let bubblyLabelCornerRadiusDevider: CGFloat = 2
    static let bubblyLabelBackgroundColor: UIColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
    static let bubblyLabelLayerShadowOffset: CGSize = CGSize(width: 0, height: 2)
    static let bubblyLabelLayerShadowRadius: CGFloat = 4
    static let bubblyLabelLayerShadowOpacity: Float = 0.5
    
    //MARK: - FavoriteButton constants
    static let favoriteButtonWidth: CGFloat = 40
    static let favoriteButtonHeight: CGFloat = 40
    
    //MARK: - CollectionViewDataSource
    static let collectionViewReloadSectionsInteger: Int = 0
    static let collectionViewItemSpacing: CGFloat = 8
    static let collectionViewNumberOfItemsPerRow: CGFloat = 2
    static let collectionViewNumberOfItemsPerRowExtraction: CGFloat = 1
    static let collectionViewHeighMultiplier: CGFloat = 1.5
    static let collectionViewMinimumInteritemSpacing: CGFloat = 8
    static let collectionViewminimumLineSpacing: CGFloat = 8
    static let scrollViewDidEndDraggingNegative: CGFloat = -1
    
    //MARK: - RoundedButton
    static let roundedButtonCornerRadiusDevider: CGFloat = 2
    static let roundedButtonBackgroundColor: UIColor = UIColor(red: 0.8, green: 0.9, blue: 1.0, alpha: 1.0)
    static let roundedButtonLayerShadowOffset: CGSize = CGSize(width: 0, height: 2)
    static let roundedButtonLayerShadowRadius: CGFloat = 4
    static let roundedButtonLayerShadowOpacity: Float = 0.5
    
    //MARK: - PopUpView
    static let popUpViewHideAnimationTransform: CGAffineTransform = CGAffineTransform(scaleX: 0.8, y: 0.8)
    static let popUpViewHideAnimationAlpha: CGFloat = 0.2
    static let popUpViewHideAnimationDuration: TimeInterval = 0.3
    static let popUpViewDismissTimeInterval: TimeInterval = 3
    static let popUpViewFrameY: CGFloat = 0
    static let popUpViewFrameX: CGFloat = 0
    
    //MARK: - CollectionViewReusableCell
    static let reusableCellFavoriteButtonFrame: CGRect = CGRect(x:1, y:1, width:35,height:35)
    static let collectionViewReusableCellLayerCornerRadius: CGFloat = 10
    static let collectionViewReusableCellLayerBorderWidth: CGFloat = 2
    
    //MARK: - TrailerView
    static let trailerViewLabelBottomAnchorConstraint: CGFloat = -8
    static let trailerViewLabelHeightAnchorConstraint: CGFloat = 50
    static let trailerViewLabelTopAnchorConstraint: CGFloat = 8
    static let trailerImageViewHeightAnchorConstant: CGFloat = 70
    static let trailerPlayButtonAlphaOnRelease: CGFloat = 1.0
    static let trailerPlayButtonAlphaOnPress: CGFloat = 0.5
    static let trailerPlayButtonAnimateDuration: TimeInterval = 0.2
    static let playIconImageViewCenterYAnchorConstraintConst: CGFloat = -35
    static let trailerPlayIconImageSize: CGSize = CGSize(width: 45, height: 35)
    static let trailerViewWidthAnchorConst: CGFloat = 120
    static let trailerVideosViewSpacing: CGFloat = 8
    
    //MARK: - GenreView
    static let gerneViewFrameAdditionalWidth: CGFloat = 10
    static let gerneViewFrameHeight: CGFloat = 25
    static let genreViewLabelShadowRadius: CGFloat = 4
    static let genreViewLabelShadowOpacity: Float = 0.6
    static let genreViewLabelShadowOffset: CGSize = CGSize(width: 0, height: 4)
    static let numberOfLinesOne: Int = 1
    static let genreLabelColor: UIColor = UIColor(red: 0.98, green: 0.85, blue: 0.12, alpha: 1)
    static let additionalXpositionSizeWidth: CGFloat = 16
    static let genreLabelAdditionalFrameOriginY: CGFloat = 16
    static let additionalYposicitonSpacing: CGFloat = 32
    static let genreLabelRowPlus: Int = 1
    static let castViewSpacing: CGFloat = 8
    static let genreLabelStartingRowHighestElement: CGFloat = 0
    static let genreLabelStartingRowPosition: Int = 0
    static let genreLabelYposition: CGFloat = 8
    static let genreLabelXposition: CGFloat = 8
    
    //MARK: - CastView
    static let castViewWidhtConstraint: CGFloat = 70
    static let cornerRadiusDevider: CGFloat = 2
    static let labelNumberOfLinesZero: Int = 0
    static let imageViewLayerBorderWidth: CGFloat = 2.0
    static let castImageViewHeightAnchor: CGFloat = 70
    static let labelHeightAnchor: CGFloat = 50
    static let firstPage: Int = 1
}

